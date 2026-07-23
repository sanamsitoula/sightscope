import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/calibration/calibration_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_shapes.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/gradient_hero_header.dart';

class _Point {
  const _Point(this.icon, this.title, this.body);
  final IconData icon;
  final String title;
  final String body;
}

const List<_Point> _kPoints = [
  _Point(
    Icons.science_outlined,
    'Science-inspired screening',
    'SightScope screens aspects of your vision using science-inspired tests. It is not a '
        'medical device and does not diagnose any condition.',
  ),
  _Point(
    Icons.info_outline,
    'Results are affected by conditions',
    'Your device, screen, lighting, and viewing distance all affect results, so they '
        "shouldn't be treated as a clinical measurement.",
  ),
  _Point(
    Icons.lock_outline,
    'Private by default',
    'Everything stays on this device. Nothing is uploaded, and there is no login.',
  ),
];

/// First-launch disclaimer gate (Task.md §15 / spec.md Gate 1: "Disclaimer
/// gate on first launch"). The app is not usable until this is accepted.
class DisclaimerScreen extends ConsumerWidget {
  const DisclaimerScreen({super.key, required this.onAccepted});

  final VoidCallback onAccepted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GradientHeroHeader(
              title: 'SightScope',
              subtitle: 'See how you see. Vision, measured.',
            ),
            Padding(
              padding: AppSpacing.padScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.gapSm,
                  Text(
                    'Before you begin',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  AppSpacing.gapMd,
                  for (final point in _kPoints) _PointCard(point: point),
                  AppSpacing.gapMd,
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.warnAmber.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppShapes.radiusLg),
                      border: Border.all(color: AppColors.warnAmber.withValues(alpha: 0.35)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.health_and_safety_outlined, color: AppColors.warnAmber),
                        AppSpacing.gapSm,
                        Expanded(
                          child: Text(
                            'If you have concerns about your vision, please consult a '
                            'qualified eye-care professional.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.gapLg,
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      key: const Key('disclaimer_accept_button'),
                      onPressed: () async {
                        await ref.read(securePrefsProvider).setDisclaimerAccepted(true);
                        onAccepted();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
                        child: Text('I understand, continue'),
                      ),
                    ),
                  ),
                  AppSpacing.gapMd,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PointCard extends StatelessWidget {
  const _PointCard({required this.point});

  final _Point point;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.brandSeed.withValues(alpha: 0.12),
            child: Icon(point.icon, color: AppColors.brandSeed),
          ),
          AppSpacing.gapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(point.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16)),
                Text(point.body, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
