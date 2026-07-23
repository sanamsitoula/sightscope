import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/secure_prefs.dart';
import 'calibration_result.dart';

final Provider<SecurePrefs> securePrefsProvider = Provider<SecurePrefs>((ref) => SecurePrefs());

/// The current screen calibration, if any. Loaded once from secure storage;
/// [CalibrationNotifier.save] both updates in-memory state and persists.
class CalibrationNotifier extends AsyncNotifier<CalibrationResult?> {
  @override
  Future<CalibrationResult?> build() async {
    final SecurePrefs prefs = ref.read(securePrefsProvider);
    final String? json = await prefs.getCalibrationJson();
    if (json == null) return null;
    return CalibrationResult.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }

  Future<void> save(CalibrationResult result) async {
    final SecurePrefs prefs = ref.read(securePrefsProvider);
    await prefs.setCalibrationJson(jsonEncode(result.toJson()));
    state = AsyncData(result);
  }
}

final AsyncNotifierProvider<CalibrationNotifier, CalibrationResult?> calibrationProvider =
    AsyncNotifierProvider<CalibrationNotifier, CalibrationResult?>(CalibrationNotifier.new);
