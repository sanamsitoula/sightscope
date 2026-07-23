import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../data/eye_wellness_settings.dart';
import '../data/eye_wellness_settings_provider.dart';

class EyeWellnessSettingsScreen extends ConsumerWidget {
  const EyeWellnessSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(eyeWellnessSettingsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Eye Wellness')),
      body: settingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Could not load settings: $e')),
        data: (settings) => ListView(
          padding: AppSpacing.padScreen,
          children: [
            SwitchListTile(
              title: const Text('Eye wellness reminders'),
              subtitle: const Text('Gentle nudges when a session runs long'),
              value: settings.remindersEnabled,
              onChanged: (v) =>
                  ref.read(eyeWellnessSettingsProvider.notifier).updateSettings((s) => s.copyWith(remindersEnabled: v)),
            ),
            SwitchListTile(
              title: const Text('Blink reminders'),
              value: settings.blinkRemindersEnabled,
              onChanged: settings.remindersEnabled
                  ? (v) => ref
                      .read(eyeWellnessSettingsProvider.notifier)
                      .updateSettings((s) => s.copyWith(blinkRemindersEnabled: v))
                  : null,
            ),
            SwitchListTile(
              title: const Text('Relaxation reminders'),
              value: settings.relaxationRemindersEnabled,
              onChanged: settings.remindersEnabled
                  ? (v) => ref
                      .read(eyeWellnessSettingsProvider.notifier)
                      .updateSettings((s) => s.copyWith(relaxationRemindersEnabled: v))
                  : null,
            ),
            AppSpacing.gapMd,
            Text('REMINDER SENSITIVITY', style: AppTypography.overline.copyWith(color: AppColors.sage)),
            for (final s in ReminderSensitivity.values)
              RadioListTile<ReminderSensitivity>(
                title: Text(_label(s)),
                subtitle: Text(_description(s)),
                value: s,
                groupValue: settings.sensitivity,
                onChanged: (v) => ref
                    .read(eyeWellnessSettingsProvider.notifier)
                    .updateSettings((current) => current.copyWith(sensitivity: v)),
              ),
            AppSpacing.gapLg,
            SwitchListTile(
              title: const Text('Camera blink detection'),
              subtitle: const Text('Not available yet — planned as an explicit-consent future feature'),
              value: false,
              onChanged: null,
            ),
            AppSpacing.gapLg,
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.softSage,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'These reminders are based on time spent in SightScope itself, not other apps. '
                'System-wide screen-time tracking would need extra device permissions and, on '
                'iOS, is not available to apps like this one at all.',
                style: AppTypography.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _label(ReminderSensitivity s) => switch (s) {
        ReminderSensitivity.gentle => 'Gentle',
        ReminderSensitivity.balanced => 'Balanced',
        ReminderSensitivity.frequent => 'Frequent',
      };

  static String _description(ReminderSensitivity s) => switch (s) {
        ReminderSensitivity.gentle => 'Reminders after longer sessions',
        ReminderSensitivity.balanced => 'The default pace',
        ReminderSensitivity.frequent => 'Reminders after shorter sessions',
      };
}
