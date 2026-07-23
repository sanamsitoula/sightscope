import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'eye_icon_painter.dart';

/// SightScope v2 premium hero header. A flat Deep Ink surface, not a
/// gradient — decorative gradients are explicitly avoided in the v2
/// "Quiet Precision" system (docs/brand.md §2, §12). Kept as
/// `GradientHeroHeader` for call-site compatibility; the name now
/// describes its historical role, not its current look.
class GradientHeroHeader extends StatelessWidget {
  const GradientHeroHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showEye = true,
    this.compact = false,
  });

  final String title;
  final String subtitle;
  final bool showEye;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: compact ? AppSpacing.lg : AppSpacing.xl,
      ),
      color: AppColors.deepInk,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: (compact ? AppTypography.sectionTitle : AppTypography.hero)
                      .copyWith(color: Colors.white),
                ),
                AppSpacing.gapSm,
                Text(
                  subtitle,
                  style: AppTypography.body.copyWith(color: Colors.white.withValues(alpha: 0.72)),
                ),
              ],
            ),
          ),
          if (showEye) ...[
            AppSpacing.gapMd,
            EyeGraphic(size: compact ? 36 : 48, irisColor: AppColors.sage),
          ],
        ],
      ),
    );
  }
}
