import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Minimal key-value backend so [SecurePrefs] can be swapped for an
/// in-memory store in tests without touching the real secure-storage
/// platform channel.
abstract interface class KeyValueStore {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
}

class SecureKeyValueStore implements KeyValueStore {
  SecureKeyValueStore([FlutterSecureStorage? storage]) : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) => _storage.write(key: key, value: value);
}

/// Test/dev-only in-memory backend. Never used in production code paths.
class InMemoryKeyValueStore implements KeyValueStore {
  final Map<String, String> _map = <String, String>{};

  @override
  Future<String?> read(String key) async => _map[key];

  @override
  Future<void> write(String key, String value) async => _map[key] = value;
}

/// Small typed wrapper over [KeyValueStore] for the few local preference
/// flags SightScope needs (disclaimer acceptance, calibration JSON). Never
/// used for raw SQL/result storage — that is Drift's job.
class SecurePrefs {
  SecurePrefs([KeyValueStore? store]) : _store = store ?? SecureKeyValueStore();

  final KeyValueStore _store;

  static const String _kDisclaimerAccepted = 'disclaimer_accepted';
  static const String _kOnboardingComplete = 'onboarding_complete';
  static const String _kCalibrationJson = 'calibration_result_json';
  static const String _kEyeWellnessSettingsJson = 'eye_wellness_settings_json';
  static const String _kDataCollectionAccepted = 'data_collection_accepted';

  Future<bool> getDisclaimerAccepted() async => (await _store.read(_kDisclaimerAccepted)) == 'true';

  Future<void> setDisclaimerAccepted(bool value) => _store.write(_kDisclaimerAccepted, value.toString());

  Future<bool> getOnboardingComplete() async => (await _store.read(_kOnboardingComplete)) == 'true';

  Future<void> setOnboardingComplete(bool value) => _store.write(_kOnboardingComplete, value.toString());

  Future<String?> getCalibrationJson() => _store.read(_kCalibrationJson);

  Future<void> setCalibrationJson(String json) => _store.write(_kCalibrationJson, json);

  Future<String?> getEyeWellnessSettingsJson() => _store.read(_kEyeWellnessSettingsJson);

  Future<void> setEyeWellnessSettingsJson(String json) =>
      _store.write(_kEyeWellnessSettingsJson, json);

  Future<bool> getDataCollectionAccepted() async =>
      (await _store.read(_kDataCollectionAccepted)) == 'true';

  Future<void> setDataCollectionAccepted(bool value) =>
      _store.write(_kDataCollectionAccepted, value.toString());
}
