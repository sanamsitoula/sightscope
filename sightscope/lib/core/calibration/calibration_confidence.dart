import 'package:flutter/foundation.dart';

import '../../shared/models/enums.dart';

/// How strongly a [CalibrationResult] should be trusted. Always carries
/// human-readable reasons; never a clinical guarantee.
@immutable
class CalibrationConfidence {
  const CalibrationConfidence({
    required this.level,
    required this.score,
    required this.reasons,
  });

  /// Coarse bucket for UI affordances.
  final ConfidenceLevel level;

  /// Continuous 0..1 score (higher = more trustworthy).
  final double score;

  /// Why this confidence was assigned (shown to the user).
  final List<String> reasons;

  /// High-confidence card calibration.
  static const CalibrationConfidence highCard = CalibrationConfidence(
    level: ConfidenceLevel.high,
    score: 0.95,
    reasons: ['Calibrated against a physical credit-card reference.'],
  );

  /// Medium-confidence device-default calibration.
  static const CalibrationConfidence mediumDeviceDefault = CalibrationConfidence(
    level: ConfidenceLevel.medium,
    score: 0.6,
    reasons: [
      'Using the device-reported screen density.',
      'Results are approximate; calibrate with a card for accuracy.',
    ],
  );

  /// Low-confidence fallback when nothing else is available.
  static const CalibrationConfidence lowFallback = CalibrationConfidence(
    level: ConfidenceLevel.low,
    score: 0.3,
    reasons: [
      'No reliable calibration available.',
      'Physical sizing is indicative only.',
    ],
  );
}
