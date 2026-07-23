/// How eagerly reminders are surfaced. Adjusts the thresholds in
/// [EyeWellnessSettings.thresholds].
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
    this.enableNotifications = false,
    this.showAppSpecificInsights = false,
    this.sensitivity = ReminderSensitivity.balanced,
  });

  final bool remindersEnabled;
  final bool blinkRemindersEnabled;
  final bool relaxationRemindersEnabled;

  /// Whether reminders may also post a system notification (in addition to
  /// the in-app card). Off by default — this is an extra permission ask,
  /// never turned on silently.
  final bool enableNotifications;

  /// Whether the dashboard may show per-app usage insights. Off by
  /// default — enabling it prompts the Android-only "Usage access"
  /// Settings screen; see [AppUsageDataSource].
  final bool showAppSpecificInsights;

  final ReminderSensitivity sensitivity;

  EyeWellnessSettings copyWith({
    bool? remindersEnabled,
    bool? blinkRemindersEnabled,
    bool? relaxationRemindersEnabled,
    bool? enableNotifications,
    bool? showAppSpecificInsights,
    ReminderSensitivity? sensitivity,
  }) {
    return EyeWellnessSettings(
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
      blinkRemindersEnabled: blinkRemindersEnabled ?? this.blinkRemindersEnabled,
      relaxationRemindersEnabled: relaxationRemindersEnabled ?? this.relaxationRemindersEnabled,
      enableNotifications: enableNotifications ?? this.enableNotifications,
      showAppSpecificInsights: showAppSpecificInsights ?? this.showAppSpecificInsights,
      sensitivity: sensitivity ?? this.sensitivity,
    );
  }

  Map<String, dynamic> toJson() => {
        'remindersEnabled': remindersEnabled,
        'blinkRemindersEnabled': blinkRemindersEnabled,
        'relaxationRemindersEnabled': relaxationRemindersEnabled,
        'enableNotifications': enableNotifications,
        'showAppSpecificInsights': showAppSpecificInsights,
        'sensitivity': sensitivity.name,
      };

  factory EyeWellnessSettings.fromJson(Map<String, dynamic> json) => EyeWellnessSettings(
        remindersEnabled: json['remindersEnabled'] as bool? ?? true,
        blinkRemindersEnabled: json['blinkRemindersEnabled'] as bool? ?? true,
        relaxationRemindersEnabled: json['relaxationRemindersEnabled'] as bool? ?? true,
        enableNotifications: json['enableNotifications'] as bool? ?? false,
        showAppSpecificInsights: json['showAppSpecificInsights'] as bool? ?? false,
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
