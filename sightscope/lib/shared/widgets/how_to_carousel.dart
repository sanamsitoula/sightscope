import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_motion.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class HowToStep {
  const HowToStep({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

/// A small, auto-advancing "how this works" animated sequence — the
/// in-app substitute for a demo video/GIF (no video asset dependency; see
/// docs/animated_howto_prompt.md for a prompt to generate a real one).
/// One flat, hairline-bordered surface — no colored icon badge.
class HowToCarousel extends StatefulWidget {
  const HowToCarousel({super.key, required this.steps});

  final List<HowToStep> steps;

  @override
  State<HowToCarousel> createState() => _HowToCarouselState();
}

class _HowToCarouselState extends State<HowToCarousel> {
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      setState(() => _index = (_index + 1) % widget.steps.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HowToStep step = widget.steps[_index];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg, horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: AppMotion.standard,
            switchInCurve: AppMotion.standardCurve,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(scale: animation, child: child),
            ),
            child: Column(
              key: ValueKey(_index),
              children: [
                Icon(step.icon, size: 32, color: AppColors.sage),
                AppSpacing.gapSm,
                Text(
                  step.label,
                  textAlign: TextAlign.center,
                  style: AppTypography.body,
                ),
              ],
            ),
          ),
          AppSpacing.gapMd,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < widget.steps.length; i++)
                AnimatedContainer(
                  duration: AppMotion.standard,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == _index ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: i == _index ? AppColors.sage : AppColors.border,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
