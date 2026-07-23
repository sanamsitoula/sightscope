import 'package:flutter/material.dart';

/// SightScope v2 app icon: "vision + precision + observation" — the eye as
/// an aperture, not a cartoon (docs/brand.md §10). Flat fills only: no
/// gradients, no glow, no violet. Minimal almond eye shape, a perfect
/// circular iris, strong negative space, one small highlight. Rasterized by
/// `test/tool/generate_app_icons.dart` — no bitmap source file.
class AppIconPainter extends CustomPainter {
  const AppIconPainter({this.cornerRadiusFraction = 0.0});

  /// 0 for a flat square (iOS masks its own corners); a small positive
  /// fraction for platforms that don't (Android legacy launcher icons).
  final double cornerRadiusFraction;

  static const Color _background = Color(0xFF101820); // ink
  static const Color _outerEye = Color(0xFFF7F8F6); // canvas
  static const Color _iris = Color(0xFF6F9188); // sage
  static const Color _pupil = Color(0xFF101820); // ink
  static const Color _highlight = Color(0xFFB39A63); // gold

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final RRect rrect =
        RRect.fromRectAndRadius(rect, Radius.circular(size.shortestSide * cornerRadiusFraction));
    canvas.drawRRect(rrect, Paint()..color = _background);

    final Offset center = rect.center;
    final double s = size.shortestSide;

    // Minimal almond eye outline (strong negative space — the eye is drawn
    // as a shape, not a set of decorative strokes).
    final double eyeHalfWidth = s * 0.34;
    final double eyeHalfHeight = s * 0.20;
    final Path almond = Path()
      ..moveTo(center.dx - eyeHalfWidth, center.dy)
      ..quadraticBezierTo(
          center.dx - eyeHalfWidth * 0.5, center.dy - eyeHalfHeight, center.dx, center.dy - eyeHalfHeight)
      ..quadraticBezierTo(
          center.dx + eyeHalfWidth * 0.5, center.dy - eyeHalfHeight, center.dx + eyeHalfWidth, center.dy)
      ..quadraticBezierTo(
          center.dx + eyeHalfWidth * 0.5, center.dy + eyeHalfHeight, center.dx, center.dy + eyeHalfHeight)
      ..quadraticBezierTo(
          center.dx - eyeHalfWidth * 0.5, center.dy + eyeHalfHeight, center.dx - eyeHalfWidth, center.dy)
      ..close();
    canvas.drawPath(almond, Paint()..color = _outerEye);

    // Perfect circular iris.
    canvas.drawCircle(center, s * 0.155, Paint()..color = _iris);

    // Pupil.
    canvas.drawCircle(center, s * 0.065, Paint()..color = _pupil);

    // One small highlight.
    canvas.drawCircle(
      Offset(center.dx - s * 0.055, center.dy - s * 0.055),
      s * 0.028,
      Paint()..color = _highlight,
    );
  }

  @override
  bool shouldRepaint(covariant AppIconPainter oldDelegate) => false;
}
