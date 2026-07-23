import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_shapes.dart';
import '../../core/theme/app_spacing.dart';
import 'eye_icon_painter.dart';

/// Brand hero banner used on onboarding and the home dashboard. Pure
/// gradient + `CustomPaint` — no image assets.
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
    final Brightness brightness = Theme.of(context).brightness;
    final List<Color> colors = brightness == Brightness.dark
        ? [const Color(0xFF0E4A52), const Color(0xFF17323B)]
        : [AppColors.brandSeed, const Color(0xFF15A9A0)];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: compact ? AppSpacing.lg : AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppShapes.radiusXl),
          bottomRight: Radius.circular(AppShapes.radiusXl),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandSeed.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: (compact
                          ? Theme.of(context).textTheme.headlineMedium
                          : Theme.of(context).textTheme.headlineLarge)
                      ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                ),
                AppSpacing.gapSm,
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white.withValues(alpha: 0.92)),
                ),
              ],
            ),
          ),
          if (showEye) ...[
            AppSpacing.gapMd,
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: EyeGraphic(size: compact ? 40 : 56, irisColor: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
