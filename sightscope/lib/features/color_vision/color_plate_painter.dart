import 'dart:math';

import 'package:flutter/material.dart';

/// Shape hidden in a procedurally generated color-dot plate.
enum ColorPlateShape { circle, triangle, square, none }

/// Original, procedurally generated pseudoisochromatic-style plate
/// (research/color_perception.md). Never uses any bundled bitmap — every
/// dot position, size, and color is computed at paint time from [seed].
class ColorPlatePainter extends CustomPainter {
  const ColorPlatePainter({required this.seed, required this.shape, required this.colorDistance});

  final int seed;
  final ColorPlateShape shape;

  /// 0 (very subtle) .. 1 (very easy) hue separation between figure and
  /// background dots.
  final double colorDistance;

  static const double _bgHue = 45; // warm background (approx "protan/deutan confusion" family)
  static const int _dotCount = 420;

  bool _inShape(Offset p, Offset center, double r) {
    final Offset d = p - center;
    switch (shape) {
      case ColorPlateShape.none:
        return false;
      case ColorPlateShape.circle:
        return d.distance <= r;
      case ColorPlateShape.square:
        return d.dx.abs() <= r * 0.8 && d.dy.abs() <= r * 0.8;
      case ColorPlateShape.triangle:
        // Equilateral triangle pointing up, inscribed roughly in radius r.
        final double x = d.dx;
        final double y = d.dy;
        if (y > r * 0.8) return false;
        final double topY = -r;
        final double leftEdge = topY + (r * 0.8 - topY) * ((x + r * 0.9) / (r * 0.9));
        final double rightEdge = topY + (r * 0.8 - topY) * ((r * 0.9 - x) / (r * 0.9));
        return y >= leftEdge && y >= rightEdge && y <= r * 0.8;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Random rnd = Random(seed);
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double shapeRadius = min(size.width, size.height) * 0.32;
    final double fgHue = (_bgHue + 60 + 90 * (1 - colorDistance)) % 360;

    for (int i = 0; i < _dotCount; i++) {
      final double x = rnd.nextDouble() * size.width;
      final double y = rnd.nextDouble() * size.height;
      final double dotR = 3 + rnd.nextDouble() * 5;
      final bool inFigure = _inShape(Offset(x, y), center, shapeRadius);
      final double hue = inFigure ? fgHue : _bgHue;
      final double lightness = 0.45 + rnd.nextDouble() * 0.15;
      final double saturation = 0.55 + rnd.nextDouble() * 0.2;
      final Color color = HSLColor.fromAHSL(1, hue, saturation, lightness).toColor();
      canvas.drawCircle(Offset(x, y), dotR, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(covariant ColorPlatePainter oldDelegate) =>
      oldDelegate.seed != seed ||
      oldDelegate.shape != shape ||
      oldDelegate.colorDistance != colorDistance;
}
