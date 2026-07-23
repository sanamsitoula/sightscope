import 'package:flutter/material.dart';

/// SightScope's app icon mark: a bold, legible eye/lens glyph on a brand
/// gradient background. Deliberately simple geometry (filled circles, no
/// thin strokes) so it stays readable down to a 20px iOS icon. Procedurally
/// drawn — no bitmap source file — and reused by the icon-generation
/// harness in `test/tool/generate_app_icons_test.dart` to rasterize every
/// required launcher-icon size.
class AppIconPainter extends CustomPainter {
  const AppIconPainter({this.cornerRadiusFraction = 0.22});

  /// 0 for a flat square (platforms that mask corners themselves, e.g. iOS)
  /// or a small positive fraction for platforms that don't.
  final double cornerRadiusFraction;

  static const Color _gradientStart = Color(0xFF11929E);
  static const Color _gradientEnd = Color(0xFF7A5AF8);
  static const Color _iris = Color(0xFF0B1220);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final RRect rrect =
        RRect.fromRectAndRadius(rect, Radius.circular(size.shortestSide * cornerRadiusFraction));
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        colors: [_gradientStart, _gradientEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);
    canvas.drawRRect(rrect, bg);

    final Offset center = rect.center;
    final double s = size.shortestSide;

    // Soft radial glow behind the eye for depth.
    canvas.drawCircle(
      center,
      s * 0.40,
      Paint()..color = Colors.white.withValues(alpha: 0.10),
    );

    // Sclera (white lens body).
    canvas.drawCircle(center, s * 0.32, Paint()..color = Colors.white);

    // Iris (bold, dark — legible at tiny sizes).
    canvas.drawCircle(center, s * 0.165, Paint()..color = _iris);

    // A thin brand-colored ring inside the iris for a bit of "camera lens"
    // character rather than a plain dot.
    canvas.drawCircle(
      center,
      s * 0.165,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = s * 0.02
        ..color = _gradientStart,
    );

    // Highlight.
    canvas.drawCircle(
      Offset(center.dx - s * 0.07, center.dy - s * 0.07),
      s * 0.045,
      Paint()..color = Colors.white.withValues(alpha: 0.95),
    );
  }

  @override
  bool shouldRepaint(covariant AppIconPainter oldDelegate) => false;
}
