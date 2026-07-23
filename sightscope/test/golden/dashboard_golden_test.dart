import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sightscope/core/theme/app_theme.dart';
import 'package:sightscope/features/home/home_dashboard_screen.dart';

void main() {
  testWidgets('HomeDashboardScreen golden', (tester) async {
    tester.view.physicalSize = const Size(1080, 2200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(MaterialApp(
      theme: AppTheme.light(),
      home: const HomeDashboardScreen(),
    ));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(HomeDashboardScreen),
      matchesGoldenFile('goldens/home_dashboard.png'),
    );
  });
}
