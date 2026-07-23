import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/gradient_hero_header.dart';
import '../data/app_usage_datasource.dart';
import '../data/eye_wellness_providers.dart';
import '../data/eye_wellness_settings_provider.dart';
import '../domain/app_usage_analyzer.dart';
import '../domain/reminder_engine.dart';
import '../domain/screen_session_tracker.dart';

/// EyeGuard entry screen: live in-app session awareness, a gentle reminder
/// when the configured threshold is reached, optional today's-usage
/// insights (Android only, permission-gated), and the One-Minute Reset
/// exercise. See docs/brand.md's EyeGuard section for what is and isn't
/// implemented.
class EyeWellnessDashboard extends ConsumerStatefulWidget {
  const EyeWellnessDashboard({super.key});

  @override
  ConsumerState<EyeWellnessDashboard> createState() => _EyeWellnessDashboardState();
}

class _EyeWellnessDashboardState extends ConsumerState<EyeWellnessDashboard> {
  ReminderLevel _lastNotified = ReminderLevel.none;

  @override
  Widget build(BuildContext context) {
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
                      if (level != ReminderLevel.none && level != _lastNotified && settings.enableNotifications) {
                        _lastNotified = level;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          final copy = kReminderCopy[level]!;
                          ref
                              .read(notificationServiceProvider)
                              .showReminder(title: copy.title, body: copy.body);
                        });
                      } else if (level == ReminderLevel.none) {
                        _lastNotified = ReminderLevel.none;
                      }
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
                  if (Platform.isAndroid) ...[
                    AppSpacing.gapLg,
                    settingsAsync.when(
                      loading: () => const SizedBox.shrink(),
                      error: (e, st) => const SizedBox.shrink(),
                      data: (settings) =>
                          settings.showAppSpecificInsights ? const _UsageInsightsCard() : const SizedBox.shrink(),
                    ),
                  ],
                  AppSpacing.gapLg,
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.warmStone,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'This tracks time spent in SightScope itself, not other apps (unless you '
                      'turn on app usage insights). It never judges your usage — only offers a '
                      'short break when you might want one.',
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
          const Text('minutes in SightScope', style: AppTypography.secondary),
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

class _UsageInsightsCard extends ConsumerWidget {
  const _UsageInsightsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grantedAsync = ref.watch(usageAccessGrantedProvider);

    return grantedAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (e, st) => const SizedBox.shrink(),
      data: (granted) {
        if (!granted) {
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
                Text('TODAY\'S SCREEN TIME', style: AppTypography.overline.copyWith(color: AppColors.sage)),
                AppSpacing.gapSm,
                const Text('Usage access isn\'t granted yet.', style: AppTypography.body),
                AppSpacing.gapSm,
                OutlinedButton(
                  onPressed: () async {
                    await ref.read(appUsageDataSourceProvider).openPermissionSettings();
                    ref.invalidate(usageAccessGrantedProvider);
                  },
                  child: const Text('Grant usage access'),
                ),
              ],
            ),
          );
        }
        return Consumer(builder: (context, ref, _) {
          final usageAsync = ref.watch(todayAppUsageProvider);
          return usageAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (e, st) => const SizedBox.shrink(),
            data: (entries) {
              final insight = AppUsageAnalyzer.analyze(entries);
              if (insight.topApps.isEmpty) {
                return const SizedBox.shrink();
              }
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
                    Text('TODAY\'S SCREEN TIME', style: AppTypography.overline.copyWith(color: AppColors.sage)),
                    AppSpacing.gapSm,
                    Text(_formatDuration(insight.totalScreenTime), style: AppTypography.cardTitle),
                    AppSpacing.gapMd,
                    for (final AppUsageEntry entry in insight.topApps)
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                AppUsageAnalyzer.friendlyName(entry.packageName),
                                style: AppTypography.body,
                              ),
                            ),
                            Text(_formatDuration(entry.duration), style: AppTypography.secondary),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        });
      },
    );
  }

  static String _formatDuration(Duration d) {
    final int h = d.inHours;
    final int m = d.inMinutes % 60;
    if (h > 0) return '${h}h ${m}m';
    return '${m}m';
  }
}
