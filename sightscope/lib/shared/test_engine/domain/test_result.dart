import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/models/enums.dart';
import 'test_confidence.dart';
import 'test_response.dart';
import 'test_scoring.dart';

part 'test_result.freezed.dart';
part 'test_result.g.dart';

/// A complete, scored test outcome. Field names mirror SPEC §19 so the Drift
/// row maps 1:1 (see `TestResultsTable` / `TestResultDao`).
///
/// This is an educational screening result, NOT a medical diagnosis.
@freezed
abstract class TestResult with _$TestResult {
  const factory TestResult({
    required String testId,

    /// Semver of the test protocol that produced this result.
    required String testVersion,

    required DateTime date,

    required String deviceModel,

    /// Human-readable screen size, e.g. "1080x2400".
    required String screenSize,

    /// True PPI used to size stimuli.
    required double screenDensity,

    double? brightnessIfAvailable,

    /// Viewing distance in millimetres.
    double? viewingDistance,

    required Eye eyeTested,
    required CorrectionUsed correctionUsed,

    @Default(<TestResponse>[]) List<TestResponse> rawResponses,

    required TestScoring scoring,
    required TestConfidence confidence,

    String? environmentNotes,

    /// Engine session id (for resume / linkage).
    String? sessionId,
  }) = _TestResult;

  factory TestResult.fromJson(Map<String, dynamic> json) =>
      _$TestResultFromJson(json);

  const TestResult._();

  // SPEC §19 convenience accessors (also stored as columns in Drift).
  double get score => scoring.score;
  double get accuracy => scoring.accuracy;
  double get reactionTime => scoring.meanReactionTimeMs;
}
