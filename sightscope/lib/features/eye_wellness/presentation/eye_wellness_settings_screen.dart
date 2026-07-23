import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../data/eye_wellness_providers.dart';
import '../data/eye_wellness_settings.dart';
import '../data/eye_wellness_settings_provider.dart';

class EyeWellnessSettingsScreen extends ConsumerWidget {
  const EyeWellnessSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(eyeWellnessSettingsProvider);
    final usageGrantedAsync = ref.watch(usageAccessGrantedProvider);

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
              onChanged: (v) => ref
                  .read(eyeWellnessSettingsProvider.notifier)
                  .updateSettings((s) => s.copyWith(remindersEnabled: v)),
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
            const Divider(height: 1),
            AppSpacing.gapLg,
            Text('DEVICE PERMISSIONS', style: AppTypography.overline.copyWith(color: AppColors.sage)),
            SwitchListTile(
              title: const Text('Notifications'),
              subtitle: const Text('Also post a system notification when a reminder is due'),
              value: settings.enableNotifications,
              onChanged: (v) async {
                if (v) {
                  final granted = await ref.read(notificationServiceProvider).requestPermission();
                  if (!granted) return;
                }
                await ref
                    .read(eyeWellnessSettingsProvider.notifier)
                    .updateSettings((s) => s.copyWith(enableNotifications: v));
              },
            ),
            SwitchListTile(
              title: const Text('App usage insights'),
              subtitle: Text(
                Platform.isAndroid
                    ? 'Shows today\'s most-used apps. Requires the Android "Usage access" '
                        'setting — you\'ll be sent to Settings to grant it.'
                    : 'Not available on this device — iOS does not provide apps access to '
                        'system-wide usage data.',
              ),
              value: settings.showAppSpecificInsights,
              onChanged: Platform.isAndroid
                  ? (v) async {
                      if (v) {
                        final granted = await ref.read(appUsageDataSourceProvider).hasPermission();
                        if (!granted) {
                          await ref.read(appUsageDataSourceProvider).openPermissionSettings();
                          ref.invalidate(usageAccessGrantedProvider);
                        }
                      }
                      await ref
                          .read(eyeWellnessSettingsProvider.notifier)
                          .updateSettings((s) => s.copyWith(showAppSpecificInsights: v));
                    }
                  : null,
            ),
            if (settings.showAppSpecificInsights && Platform.isAndroid)
              usageGrantedAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (e, st) => const SizedBox.shrink(),
                data: (granted) => granted
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(left: AppSpacing.md, bottom: AppSpacing.sm),
                        child: TextButton(
                          onPressed: () async {
                            await ref.read(appUsageDataSourceProvider).openPermissionSettings();
                            ref.invalidate(usageAccessGrantedProvider);
                          },
                          child: const Text('Open usage access settings'),
                        ),
                      ),
              ),
            AppSpacing.gapLg,
            const SwitchListTile(
              title: Text('Camera blink detection'),
              subtitle: Text('Not available yet — planned as an explicit-consent future feature'),
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
              child: const Text(
                'Reminders are based on time spent in SightScope itself. App usage insights, '
                'if enabled, only read how long apps ran in the foreground today — never their '
                'content — and stay on this device.',
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
