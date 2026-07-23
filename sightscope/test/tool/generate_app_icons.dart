// Icon-generation harness, not a regression test. Run once (or whenever
// the icon design changes) with:
//   flutter test test/tool/generate_app_icons_test.dart
// It rasterizes AppIconPainter at every required launcher-icon size and
// overwrites the platform icon files directly, so SightScope never needs
// a bundled source image or an image-editing dependency.
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sightscope/shared/widgets/app_icon_painter.dart';

class _IconTarget {
  const _IconTarget(this.path, this.sizePx, {this.rounded = false});
  final String path;
  final int sizePx;

  /// Android legacy launcher icons look better with a touch of rounding;
  /// iOS applies its own corner mask, so those stay flat squares.
  final bool rounded;
}

const List<_IconTarget> _kAndroidTargets = [
  _IconTarget('android/app/src/main/res/mipmap-mdpi/ic_launcher.png', 48, rounded: true),
  _IconTarget('android/app/src/main/res/mipmap-hdpi/ic_launcher.png', 72, rounded: true),
  _IconTarget('android/app/src/main/res/mipmap-xhdpi/ic_launcher.png', 96, rounded: true),
  _IconTarget('android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png', 144, rounded: true),
  _IconTarget('android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png', 192, rounded: true),
];

const String _kIosDir = 'ios/Runner/Assets.xcassets/AppIcon.appiconset';

const List<_IconTarget> _kIosTargets = [
  _IconTarget('$_kIosDir/Icon-App-20x20@1x.png', 20),
  _IconTarget('$_kIosDir/Icon-App-20x20@2x.png', 40),
  _IconTarget('$_kIosDir/Icon-App-20x20@3x.png', 60),
  _IconTarget('$_kIosDir/Icon-App-29x29@1x.png', 29),
  _IconTarget('$_kIosDir/Icon-App-29x29@2x.png', 58),
  _IconTarget('$_kIosDir/Icon-App-29x29@3x.png', 87),
  _IconTarget('$_kIosDir/Icon-App-40x40@1x.png', 40),
  _IconTarget('$_kIosDir/Icon-App-40x40@2x.png', 80),
  _IconTarget('$_kIosDir/Icon-App-40x40@3x.png', 120),
  _IconTarget('$_kIosDir/Icon-App-60x60@2x.png', 120),
  _IconTarget('$_kIosDir/Icon-App-60x60@3x.png', 180),
  _IconTarget('$_kIosDir/Icon-App-76x76@1x.png', 76),
  _IconTarget('$_kIosDir/Icon-App-76x76@2x.png', 152),
  _IconTarget('$_kIosDir/Icon-App-83.5x83.5@2x.png', 167),
  _IconTarget('$_kIosDir/Icon-App-1024x1024@1x.png', 1024),
];

void main() {
  testWidgets('generate all launcher icon files from AppIconPainter', (tester) async {
    // Large enough to fit the biggest target (1024x1024 App Store icon)
    // without the test binding clipping/overflowing it.
    tester.view.physicalSize = const Size(1200, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    for (final target in [..._kAndroidTargets, ..._kIosTargets]) {
      final GlobalKey boundaryKey = GlobalKey();
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          // UnconstrainedBox gives the sized child loose constraints so it
          // renders at its exact requested size regardless of the test
          // binding's default (800x600) viewport, which otherwise forces
          // tight constraints onto the whole tree.
          child: UnconstrainedBox(
            child: RepaintBoundary(
              key: boundaryKey,
              child: SizedBox(
                width: target.sizePx.toDouble(),
                height: target.sizePx.toDouble(),
                child: CustomPaint(
                  painter: AppIconPainter(cornerRadiusFraction: target.rounded ? 0.22 : 0.0),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      await tester.runAsync(() async {
        final RenderRepaintBoundary boundary =
            boundaryKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
        final ui.Image image = await boundary.toImage(pixelRatio: 1.0);
        final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        final File file = File(target.path);
        await file.parent.create(recursive: true);
        await file.writeAsBytes(byteData!.buffer.asUint8List());
      });
    }
  });
}
