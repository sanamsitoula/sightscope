import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/gradient_hero_header.dart';
import '../data/eye_wellness_settings_provider.dart';
import '../domain/reminder_engine.dart';
import '../domain/screen_session_tracker.dart';

/// EyeGuard entry screen: live in-app session awareness, a gentle reminder
/// when the configured threshold is reached, and the One-Minute Reset
/// exercise. See docs/brand.md's EyeGuard section for what is and isn't
/// implemented (no cross-app tracking, no notifications, no camera).
class EyeWellnessDashboard extends ConsumerWidget {
  const EyeWellnessDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Duration session = ref.watch(screenSessionProvider);
    final settingsAsync = ref.watch(eyeWellnessSettingsProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GradientHeroHeader(
              title: 'Eye Wellness',
              subtitle: 'A quiet companion for healthier screen habits.',
              compact: true,
              showEye: false,
            ),
            Padding(
              padding: AppSpacing.padScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SessionCard(session: session),
                  AppSpacing.gapMd,
                  settingsAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (e, st) => const SizedBox.shrink(),
                    data: (settings) {
                      final ReminderLevel level = ReminderEngine.evaluate(
                        continuousDuration: session,
                        settings: settings,
                      );
                      if (level == ReminderLevel.none) return const SizedBox.shrink();
                      final copy = kReminderCopy[level]!;
                      return _ReminderCard(copy: copy);
                    },
                  ),
                  AppSpacing.gapLg,
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => context.push('/eye-wellness/reset'),
                      child: const Text('Start one-minute reset'),
                    ),
                  ),
                  AppSpacing.gapSm,
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => context.push('/eye-wellness/settings'),
                      child: const Text('Eye wellness settings'),
                    ),
                  ),
                  AppSpacing.gapLg,
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.warmStone,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'This tracks time spent in SightScope itself, not other apps. It never '
                      'judges your usage — only offers a short break when you might want one.',
                      style: AppTypography.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session});

  final Duration session;

  @override
  Widget build(BuildContext context) {
    final int minutes = session.inMinutes;
    final int seconds = session.inSeconds % 60;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('THIS SESSION', style: AppTypography.overline.copyWith(color: AppColors.sage)),
          AppSpacing.gapSm,
          Text(
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
            style: AppTypography.metric,
          ),
          Text('minutes in SightScope', style: AppTypography.secondary),
        ],
      ),
    );
  }
}

class _ReminderCard extends StatelessWidget {
  const _ReminderCard({required this.copy});

  final ReminderCopy copy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.softSage,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(copy.title, style: AppTypography.cardTitle),
          AppSpacing.gapXs,
          Text(copy.body, style: AppTypography.body),
        ],
      ),
    );
  }
}
