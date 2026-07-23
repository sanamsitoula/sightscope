import 'dart:math';

import 'package:flutter/material.dart';

/// Random-dot kinematogram painter (research/motion_perception.md).
///
/// Dot positions are a pure function of [t] (0..1 trial progress) and each
/// dot's index/[seed] — no mutable per-frame state is kept, so a single
/// `AnimationController` value drives the whole animation deterministically.
class RdkPainter extends CustomPainter {
  const RdkPainter({
    required this.t,
    required this.coherence,
    required this.direction,
    required this.seed,
    this.dotCount = 140,
    this.dotColor = Colors.white,
    this.backgroundColor = Colors.black,
  });

  final double t;
  final double coherence;
  final String direction;
  final int seed;
  final int dotCount;
  final Color dotColor;
  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = backgroundColor);
    final Paint dotPaint = Paint()..color = dotColor;
    final int coherentCount = (dotCount * coherence).round();
    final double dir = direction == 'left' ? -1.0 : 1.0;

    for (int i = 0; i < dotCount; i++) {
      final Random base = Random(seed + i);
      final double baseX = base.nextDouble();
      final double baseY = base.nextDouble();
      double x;
      double y;
      if (i < coherentCount) {
        x = (baseX + dir * t * 0.6) % 1.0;
        if (x < 0) x += 1.0;
        y = baseY;
      } else {
        final int bucket = (t * 12).floor();
        final Random noise = Random(seed + i * 1000 + bucket);
        x = noise.nextDouble();
        y = noise.nextDouble();
      }
      canvas.drawCircle(Offset(x * size.width, y * size.height), 2.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant RdkPainter oldDelegate) =>
      oldDelegate.t != t ||
      oldDelegate.coherence != coherence ||
      oldDelegate.direction != direction ||
      oldDelegate.seed != seed;
}
