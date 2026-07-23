import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/calibration/calibration_provider.dart';
import 'eye_wellness_settings.dart';

/// Persisted eye-wellness preferences, same secure-storage pattern as
/// [calibrationProvider].
class EyeWellnessSettingsNotifier extends AsyncNotifier<EyeWellnessSettings> {
  @override
  Future<EyeWellnessSettings> build() async {
    final String? json = await ref.read(securePrefsProvider).getEyeWellnessSettingsJson();
    if (json == null) return const EyeWellnessSettings();
    return EyeWellnessSettings.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }

  Future<void> updateSettings(EyeWellnessSettings Function(EyeWellnessSettings) transform) async {
    final EyeWellnessSettings current = state.value ?? const EyeWellnessSettings();
    final EyeWellnessSettings next = transform(current);
    await ref.read(securePrefsProvider).setEyeWellnessSettingsJson(jsonEncode(next.toJson()));
    state = AsyncData(next);
  }
}

final AsyncNotifierProvider<EyeWellnessSettingsNotifier, EyeWellnessSettings>
    eyeWellnessSettingsProvider =
    AsyncNotifierProvider<EyeWellnessSettingsNotifier, EyeWellnessSettings>(
  EyeWellnessSettingsNotifier.new,
);
