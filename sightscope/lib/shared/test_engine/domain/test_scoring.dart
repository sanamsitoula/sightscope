import 'package:freezed_annotation/freezed_annotation.dart';

import 'test_response.dart';

part 'test_scoring.freezed.dart';
part 'test_scoring.g.dart';

/// Deterministic outcome of scoring a list of [responses].
///
/// Scoring must be pure and reproducible: identical inputs produce identical
/// [TestScoring]. [metrics] holds test-specific derived values (e.g. logMAR,
/// Pelli-Robson contrast).
@freezed
abstract class TestScoring with _$TestScoring {
  const factory TestScoring({
    /// 0..1 fraction of correct responses.
    @Default(0) double accuracy,

    /// Test-defined primary score (meaning set by the test definition).
    @Default(0) double score,

    /// Mean response latency in milliseconds (0 if not applicable).
    @Default(0) double meanReactionTimeMs,

    /// Test-specific derived values (always JSON primitives).
    @Default(<String, dynamic>{}) Map<String, dynamic> metrics,

    /// Number of responses that were scored.
    @Default(0) int n,
  }) = _TestScoring;

  factory TestScoring.fromJson(Map<String, dynamic> json) =>
      _$TestScoringFromJson(json);

  const TestScoring._();

  /// Convenience: build from a flat response list using simple accuracy + mean RT.
  factory TestScoring.fromResponses(List<TestResponse> responses) {
    if (responses.isEmpty) {
      return const TestScoring();
    }
    int correct = 0;
    int rtSum = 0;
    int rtCount = 0;
    for (final TestResponse r in responses) {
      if (r.correct) correct++;
      if (r.durationMillis > 0) {
        rtSum += r.durationMillis;
        rtCount++;
      }
    }
    return TestScoring(
      accuracy: correct / responses.length,
      score: correct / responses.length,
      meanReactionTimeMs: rtCount > 0 ? rtSum / rtCount : 0,
      n: responses.length,
    );
  }
}
