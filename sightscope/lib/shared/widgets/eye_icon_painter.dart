import 'dart:math';

import 'package:flutter/material.dart';

/// A stylized, procedurally drawn eye — used as SightScope's brand flourish
/// on onboarding/dashboard headers. Deliberately not a bitmap asset: the
/// whole app draws its own graphics via `CustomPaint` (Task.md's "no
/// bundled assets" principle applied to decorative art, not just stimuli).
class EyeIconPainter extends CustomPainter {
  const EyeIconPainter({
    required this.irisColor,
    required this.scleraColor,
    this.pupilColor = const Color(0xFF0B0F12),
    this.highlightColor = Colors.white,
    this.openness = 1.0,
  });

  final Color irisColor;
  final Color scleraColor;
  final Color pupilColor;
  final Color highlightColor;

  /// 0 (closed) .. 1 (fully open) — lets callers animate a soft blink.
  final double openness;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double w = size.width;
    final double h = size.height * openness.clamp(0.05, 1.0);

    final Path almond = Path()
      ..moveTo(center.dx - w / 2, center.dy)
      ..quadraticBezierTo(center.dx - w / 4, center.dy - h / 2, center.dx, center.dy - h / 2)
      ..quadraticBezierTo(center.dx + w / 4, center.dy - h / 2, center.dx + w / 2, center.dy)
      ..quadraticBezierTo(center.dx + w / 4, center.dy + h / 2, center.dx, center.dy + h / 2)
      ..quadraticBezierTo(center.dx - w / 4, center.dy + h / 2, center.dx - w / 2, center.dy)
      ..close();

    canvas.save();
    canvas.clipPath(almond);
    canvas.drawRect(Offset.zero & size, Paint()..color = scleraColor);

    final double irisRadius = min(w, size.height) * 0.28;
    canvas.drawCircle(center, irisRadius, Paint()..color = irisColor);
    canvas.drawCircle(center, irisRadius * 0.45, Paint()..color = pupilColor);
    canvas.drawCircle(
      Offset(center.dx - irisRadius * 0.18, center.dy - irisRadius * 0.18),
      irisRadius * 0.14,
      Paint()..color = highlightColor.withValues(alpha: 0.9),
    );
    canvas.restore();

    canvas.drawPath(
      almond,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..color = pupilColor.withValues(alpha: 0.85),
    );
  }

  @override
  bool shouldRepaint(covariant EyeIconPainter oldDelegate) =>
      oldDelegate.irisColor != irisColor ||
      oldDelegate.scleraColor != scleraColor ||
      oldDelegate.openness != openness;
}

/// Convenience widget wrapper, sized as a square.
class EyeGraphic extends StatelessWidget {
  const EyeGraphic({super.key, required this.size, this.irisColor = const Color(0xFF6F9188)});

  final double size;
  final Color irisColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 0.6,
      child: CustomPaint(
        painter: EyeIconPainter(irisColor: irisColor, scleraColor: Colors.white),
      ),
    );
  }
}
