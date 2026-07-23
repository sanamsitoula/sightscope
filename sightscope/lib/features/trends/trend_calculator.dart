import 'package:sightscope/shared/test_engine/domain/test_result.dart';

/// Direction of change between a dimension's baseline and current result.
/// Deliberately neutral naming — the UI must never use alarmist language
/// (Task.md §16: "Never create one combined intelligence or brain score."
/// and "non-alarmist language").
enum TrendDirection { higher, lower, stable, insufficientData }

class TrendSummary {
  const TrendSummary({
    required this.testId,
    required this.baseline,
    required this.current,
    required this.sampleCount,
    required this.direction,
  });

  final String testId;
  final TestResult baseline;
  final TestResult current;
  final int sampleCount;
  final TrendDirection direction;
}

/// Deterministic, explainable statistics only — no AI, no inferred trends
/// (ai.md AI-02: "The underlying statistics must always be calculated
/// using normal deterministic code").
class TrendCalculator {
  const TrendCalculator._();

  /// Per-test-dimension list of what a "higher score" means. This is
  /// display metadata only — it never changes scoring, only how a trend's
  /// direction is computed.
  static const Map<String, bool> higherScoreMeansHigherOnScale = {
    'visual_acuity': true,
    'near_vision': true,
    'contrast_sensitivity': true,
    'color_vision': true,
    'reaction_time': true,
    'peripheral_vision': true,
    'visual_attention': true,
    'visual_memory': true,
    'motion_perception': true,
    'depth_perception': true,
    'eye_fatigue': true,
  };

  static TrendSummary? summarize(String testId, List<TestResult> resultsForTest) {
    if (resultsForTest.isEmpty) return null;
    final List<TestResult> sorted = [...resultsForTest]..sort((a, b) => a.date.compareTo(b.date));
    final TestResult baseline = sorted.first;
    final TestResult current = sorted.last;

    TrendDirection direction;
    if (sorted.length < 2) {
      direction = TrendDirection.insufficientData;
    } else {
      final double diff = current.score - baseline.score;
      final double tolerance = (baseline.score.abs() * 0.05).clamp(0.01, double.infinity);
      if (diff.abs() <= tolerance) {
        direction = TrendDirection.stable;
      } else {
        direction = diff > 0 ? TrendDirection.higher : TrendDirection.lower;
      }
    }

    return TrendSummary(
      testId: testId,
      baseline: baseline,
      current: current,
      sampleCount: sorted.length,
      direction: direction,
    );
  }

  static Map<String, List<TestResult>> groupByTestId(List<TestResult> results) {
    final Map<String, List<TestResult>> grouped = {};
    for (final r in results) {
      grouped.putIfAbsent(r.testId, () => []).add(r);
    }
    return grouped;
  }
}
