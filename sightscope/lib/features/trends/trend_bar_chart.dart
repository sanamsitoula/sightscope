import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Minimal two-bar baseline-vs-current chart. Deliberately plain — this is
/// a screening trend indicator, not a data-dashboard visualization.
class TrendBarChart extends StatelessWidget {
  const TrendBarChart({super.key, required this.baseline, required this.current});

  final double baseline;
  final double current;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: CustomPaint(painter: _TrendBarPainter(baseline: baseline, current: current)),
    );
  }
}

class _TrendBarPainter extends CustomPainter {
  const _TrendBarPainter({required this.baseline, required this.current});

  final double baseline;
  final double current;

  @override
  void paint(Canvas canvas, Size size) {
    final double maxValue = [baseline.abs(), current.abs(), 0.001].reduce((a, b) => a > b ? a : b);
    final double barWidth = size.width * 0.28;
    final double baselineHeight = size.height * (baseline.abs() / maxValue).clamp(0.02, 1.0);
    final double currentHeight = size.height * (current.abs() / maxValue).clamp(0.02, 1.0);

    final Paint baselinePaint = Paint()..color = AppColors.border;
    final Paint currentPaint = Paint()..color = AppColors.sage;

    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.18, size.height - baselineHeight, barWidth, baselineHeight),
      baselinePaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.54, size.height - currentHeight, barWidth, currentHeight),
      currentPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TrendBarPainter oldDelegate) =>
      oldDelegate.baseline != baseline || oldDelegate.current != current;
}
