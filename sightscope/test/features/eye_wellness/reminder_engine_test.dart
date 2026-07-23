import 'package:flutter_test/flutter_test.dart';
import 'package:sightscope/features/eye_wellness/data/eye_wellness_settings.dart';
import 'package:sightscope/features/eye_wellness/domain/reminder_engine.dart';

void main() {
  group('ReminderEngine', () {
    test('returns none below any threshold', () {
      final level = ReminderEngine.evaluate(
        continuousDuration: const Duration(minutes: 5),
        settings: const EyeWellnessSettings(),
      );
      expect(level, ReminderLevel.none);
    });

    test('returns blink once the blink threshold is reached (balanced = 20 min)', () {
      final level = ReminderEngine.evaluate(
        continuousDuration: const Duration(minutes: 20),
        settings: const EyeWellnessSettings(),
      );
      expect(level, ReminderLevel.blink);
    });

    test('returns relaxation once the relaxation threshold is reached (balanced = 30 min)', () {
      final level = ReminderEngine.evaluate(
        continuousDuration: const Duration(minutes: 30),
        settings: const EyeWellnessSettings(),
      );
      expect(level, ReminderLevel.relaxation);
    });

    test('respects the minimum reminder interval to avoid notification fatigue', () {
      final level = ReminderEngine.evaluate(
        continuousDuration: const Duration(minutes: 40),
        settings: const EyeWellnessSettings(),
        lastReminderAt: DateTime(2026, 1, 1, 12, 0),
        now: DateTime(2026, 1, 1, 12, 5),
      );
      expect(level, ReminderLevel.none);
    });

    test('fires again once the minimum interval has elapsed', () {
      final level = ReminderEngine.evaluate(
        continuousDuration: const Duration(minutes: 40),
        settings: const EyeWellnessSettings(),
        lastReminderAt: DateTime(2026, 1, 1, 12, 0),
        now: DateTime(2026, 1, 1, 12, 11),
      );
      expect(level, ReminderLevel.relaxation);
    });

    test('returns none when reminders are disabled entirely', () {
      final level = ReminderEngine.evaluate(
        continuousDuration: const Duration(minutes: 60),
        settings: const EyeWellnessSettings(remindersEnabled: false),
      );
      expect(level, ReminderLevel.none);
    });

    test('skips blink level when blink reminders are individually disabled', () {
      final level = ReminderEngine.evaluate(
        continuousDuration: const Duration(minutes: 20),
        settings: const EyeWellnessSettings(blinkRemindersEnabled: false),
      );
      expect(level, ReminderLevel.none);
    });

    test('frequent sensitivity triggers earlier than gentle sensitivity', () {
      const duration = Duration(minutes: 15);
      final frequent = ReminderEngine.evaluate(
        continuousDuration: duration,
        settings: const EyeWellnessSettings(sensitivity: ReminderSensitivity.frequent),
      );
      final gentle = ReminderEngine.evaluate(
        continuousDuration: duration,
        settings: const EyeWellnessSettings(sensitivity: ReminderSensitivity.gentle),
      );
      expect(frequent, isNot(ReminderLevel.none));
      expect(gentle, ReminderLevel.none);
    });
  });

  group('EyeWellnessSettings', () {
    test('round-trips through JSON', () {
      const settings = EyeWellnessSettings(
        remindersEnabled: false,
        blinkRemindersEnabled: false,
        sensitivity: ReminderSensitivity.frequent,
      );
      final restored = EyeWellnessSettings.fromJson(settings.toJson());
      expect(restored.remindersEnabled, false);
      expect(restored.blinkRemindersEnabled, false);
      expect(restored.relaxationRemindersEnabled, true);
      expect(restored.sensitivity, ReminderSensitivity.frequent);
    });
  });
}
