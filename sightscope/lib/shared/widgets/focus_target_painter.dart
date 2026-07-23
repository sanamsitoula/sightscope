import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// The "Focus Target" brand graphic (docs/brand.md §11) — used for
/// Reaction Time and Attention. A scope/reticle mark: concentric rings and
/// a filled center, flat colors only, no glow or gradient.
class FocusTargetPainter extends CustomPainter {
  const FocusTargetPainter({
    this.ringColor = AppColors.sage,
    this.centerColor = AppColors.deepSage,
  });

  final Color ringColor;
  final Color centerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double r = size.shortestSide / 2;

    canvas.drawCircle(
      center,
      r * 0.92,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.06
        ..color = AppColors.border,
    );
    canvas.drawCircle(
      center,
      r * 0.62,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.07
        ..color = ringColor,
    );
    canvas.drawCircle(center, r * 0.30, Paint()..color = centerColor);

    // Cardinal ticks, like a scope reticle.
    final Paint tick = Paint()
      ..color = ringColor
      ..strokeWidth = r * 0.06;
    for (final Offset dir in const [Offset(0, -1), Offset(0, 1), Offset(-1, 0), Offset(1, 0)]) {
      canvas.drawLine(
        center + dir * (r * 0.92),
        center + dir * (r * 1.08),
        tick,
      );
    }
  }

  @override
  bool shouldRepaint(covariant FocusTargetPainter oldDelegate) =>
      oldDelegate.ringColor != ringColor || oldDelegate.centerColor != centerColor;
}

/// Convenience square widget wrapper.
class FocusTarget extends StatelessWidget {
  const FocusTarget({super.key, required this.size, this.ringColor = AppColors.sage, this.centerColor = AppColors.deepSage});

  final double size;
  final Color ringColor;
  final Color centerColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: FocusTargetPainter(ringColor: ringColor, centerColor: centerColor)),
    );
  }
}
