import 'package:freezed_annotation/freezed_annotation.dart';

import 'calibration_confidence.dart';

part 'calibration_result.freezed.dart';
part 'calibration_result.g.dart';

/// How the screen PPI was established.
enum CalibrationMethod {
  /// User aligned a physical credit card (ISO/IEC 7810-1 ID-1) to the screen.
  creditCard,

  /// Derived from the device-reported pixel dimensions + physical diagonal.
  deviceDefault,

  /// Last-resort fallback when no calibration is possible.
  fallback,
}

/// Immutable result of a screen calibration. Persisted in secure storage so
/// stimulus sizing stays consistent between sessions.
///
/// Confidence is derived from [method] (not serialized) — see [confidence].
@freezed
abstract class CalibrationResult with _$CalibrationResult {
  const factory CalibrationResult({
    /// True pixels-per-inch for this screen.
    required double ppi,

    /// How the PPI was established.
    required CalibrationMethod method,

    /// When the calibration was performed.
    required DateTime calibratedAt,

    /// Native screen width in pixels (0 if unknown).
    @Default(0) int screenWpx,

    /// Native screen height in pixels (0 if unknown).
    @Default(0) int screenHpx,

    /// Physical diagonal in inches (0 if unknown).
    @Default(0.0) double diagonalInches,

    /// Recommended viewing distance (mm) used when sizing stimuli.
    @Default(400.0) double viewingDistanceMm,
  }) = _CalibrationResult;

  factory CalibrationResult.fromJson(Map<String, dynamic> json) =>
      _$CalibrationResultFromJson(json);

  const CalibrationResult._();

  /// Derived (non-serialized) confidence bucket.
  CalibrationConfidence get confidence => switch (method) {
        CalibrationMethod.creditCard => CalibrationConfidence.highCard,
        CalibrationMethod.deviceDefault =>
          CalibrationConfidence.mediumDeviceDefault,
        CalibrationMethod.fallback => CalibrationConfidence.lowFallback,
      };

  bool get isCardCalibrated => method == CalibrationMethod.creditCard;
}
