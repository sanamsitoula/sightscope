/// How eagerly reminders are surfaced. Adjusts the thresholds in
/// [EyeWellnessSettings.thresholdsForSensitivity].
enum ReminderSensitivity { gentle, balanced, frequent }

/// User-configurable eye-wellness preferences (EyeGuard spec §3/§15).
/// Persisted as JSON via [SecurePrefs], same pattern as calibration.
///
/// Camera-based blink detection is intentionally not represented here yet —
/// it is a future, explicitly-consented, AI-gated feature (see ai.md
/// AI-04) and is out of scope for this implementation.
class EyeWellnessSettings {
  const EyeWellnessSettings({
    this.remindersEnabled = true,
    this.blinkRemindersEnabled = true,
    this.relaxationRemindersEnabled = true,
    this.sensitivity = ReminderSensitivity.balanced,
  });

  final bool remindersEnabled;
  final bool blinkRemindersEnabled;
  final bool relaxationRemindersEnabled;
  final ReminderSensitivity sensitivity;

  EyeWellnessSettings copyWith({
    bool? remindersEnabled,
    bool? blinkRemindersEnabled,
    bool? relaxationRemindersEnabled,
    ReminderSensitivity? sensitivity,
  }) {
    return EyeWellnessSettings(
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
      blinkRemindersEnabled: blinkRemindersEnabled ?? this.blinkRemindersEnabled,
      relaxationRemindersEnabled: relaxationRemindersEnabled ?? this.relaxationRemindersEnabled,
      sensitivity: sensitivity ?? this.sensitivity,
    );
  }

  Map<String, dynamic> toJson() => {
        'remindersEnabled': remindersEnabled,
        'blinkRemindersEnabled': blinkRemindersEnabled,
        'relaxationRemindersEnabled': relaxationRemindersEnabled,
        'sensitivity': sensitivity.name,
      };

  factory EyeWellnessSettings.fromJson(Map<String, dynamic> json) => EyeWellnessSettings(
        remindersEnabled: json['remindersEnabled'] as bool? ?? true,
        blinkRemindersEnabled: json['blinkRemindersEnabled'] as bool? ?? true,
        relaxationRemindersEnabled: json['relaxationRemindersEnabled'] as bool? ?? true,
        sensitivity: ReminderSensitivity.values.firstWhere(
          (s) => s.name == json['sensitivity'],
          orElse: () => ReminderSensitivity.balanced,
        ),
      );

  /// (blink reminder, relaxation reminder) thresholds for this sensitivity.
  ({Duration blink, Duration relaxation}) get thresholds => switch (sensitivity) {
        ReminderSensitivity.gentle => (
            blink: const Duration(minutes: 30),
            relaxation: const Duration(minutes: 45),
          ),
        ReminderSensitivity.balanced => (
            blink: const Duration(minutes: 20),
            relaxation: const Duration(minutes: 30),
          ),
        ReminderSensitivity.frequent => (
            blink: const Duration(minutes: 12),
            relaxation: const Duration(minutes: 20),
          ),
      };
}
