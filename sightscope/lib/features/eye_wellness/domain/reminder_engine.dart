import '../data/eye_wellness_settings.dart';

enum ReminderLevel { none, blink, relaxation }

class ReminderCopy {
  const ReminderCopy({required this.title, required this.body});
  final String title;
  final String body;
}

const Map<ReminderLevel, ReminderCopy> kReminderCopy = {
  ReminderLevel.blink: ReminderCopy(
    title: 'Take a moment',
    body: "You've been focused on the screen for a while. Blink slowly a few times and let your "
        'eyes relax.',
  ),
  ReminderLevel.relaxation: ReminderCopy(
    title: 'A short reset?',
    body: 'Your eyes may benefit from a short pause. Try the one-minute reset when you have a '
        'moment.',
  ),
};

/// Deterministic reminder-threshold rules engine (EyeGuard spec §3/§14).
/// No AI, no network — a pure function of elapsed time and user settings,
/// same "deterministic first" principle as ai.md's insight-engine rule.
/// Never judgmental: only "blink" and "relaxation" levels exist, never a
/// shaming message.
class ReminderEngine {
  const ReminderEngine._();

  /// Reminders never repeat more often than this, regardless of how long
  /// the session continues, to avoid notification fatigue.
  static const Duration minimumReminderInterval = Duration(minutes: 10);

  static ReminderLevel evaluate({
    required Duration continuousDuration,
    required EyeWellnessSettings settings,
    DateTime? lastReminderAt,
    DateTime? now,
  }) {
    if (!settings.remindersEnabled) return ReminderLevel.none;

    final DateTime effectiveNow = now ?? DateTime.now();
    if (lastReminderAt != null &&
        effectiveNow.difference(lastReminderAt) < minimumReminderInterval) {
      return ReminderLevel.none;
    }

    final thresholds = settings.thresholds;
    if (settings.relaxationRemindersEnabled && continuousDuration >= thresholds.relaxation) {
      return ReminderLevel.relaxation;
    }
    if (settings.blinkRemindersEnabled && continuousDuration >= thresholds.blink) {
      return ReminderLevel.blink;
    }
    return ReminderLevel.none;
  }
}
