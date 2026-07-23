import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/calibration/calibration_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
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
              subtitle: 'See how you see. Vision, measured with clarity.',
            ),
            Padding(
              padding: AppSpacing.padScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.gapSm,
                  const Text('Before you begin', style: AppTypography.sectionTitle),
                  AppSpacing.gapMd,
                  for (final point in _kPoints) _PointCard(point: point),
                  AppSpacing.gapMd,
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.softSage,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.health_and_safety_outlined, color: AppColors.deepSage),
                        AppSpacing.gapSm,
                        Expanded(
                          child: Text(
                            'If you have concerns about your vision, please consult a '
                            'qualified eye-care professional.',
                            style: AppTypography.secondary,
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
                      child: const Text('I understand, continue'),
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
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(point.icon, size: 20, color: AppColors.sage),
          AppSpacing.gapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(point.title, style: AppTypography.cardTitle),
                Text(point.body, style: AppTypography.secondary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
