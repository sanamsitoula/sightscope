import 'dart:math';

import 'package:sightscope/shared/models/enums.dart';
import 'package:sightscope/shared/test_engine/domain/test_confidence.dart';
import 'package:sightscope/shared/test_engine/domain/test_definition.dart';
import 'package:sightscope/shared/test_engine/domain/test_response.dart';
import 'package:sightscope/shared/test_engine/domain/test_scoring.dart';
import 'package:sightscope/shared/test_engine/domain/test_stimulus.dart';

const int kDistractorColor = 0xFF3F6FBF;
const int kTargetColor = 0xFFE0632E;

/// Fixed-sequence color-odd-one-out visual search test
/// (research/visual_attention.md). Distractor count increases across
/// trials; scoring reports accuracy and per-set-size mean reaction time.
class VisualAttentionTestDefinition extends TestDefinition {
  VisualAttentionTestDefinition({Random? random}) : _random = random ?? Random();

  final Random _random;

  @override
  String get id => 'visual_attention';
  @override
  String get version => '1.0.0';
  @override
  String get title => 'Visual Attention';
  @override
  String get shortDescription => 'Screens how quickly you can find an odd-colored target.';

  static const List<int> practiceSetSizes = [4];
  static const List<int> mainSetSizes = [4, 4, 8, 8, 12, 12];

  TestStimulus _buildTrial(int itemCount, String id) {
    final int targetIndex = _random.nextInt(itemCount);
    final List<Map<String, double>> positions = _nonOverlappingPositions(itemCount);
    return TestStimulus(
      id: id,
      payload: {
        'itemCount': itemCount,
        'targetIndex': targetIndex,
        'positions': positions,
        'targetColor': kTargetColor,
        'distractorColor': kDistractorColor,
      },
    );
  }

  List<Map<String, double>> _nonOverlappingPositions(int count) {
    const int gridSize = 4;
    final List<int> cells = List.generate(gridSize * gridSize, (i) => i)..shuffle(_random);
    final List<Map<String, double>> positions = [];
    for (int i = 0; i < count; i++) {
      final int cell = cells[i % cells.length];
      final int row = cell ~/ gridSize;
      final int col = cell % gridSize;
      const double jitter = 0.06;
      positions.add({
        'dx': (col + 0.5) / gridSize + (_random.nextDouble() - 0.5) * jitter,
        'dy': (row + 0.5) / gridSize + (_random.nextDouble() - 0.5) * jitter,
      });
    }
    return positions;
  }

  @override
  List<TestStimulus> buildPracticeStimuli() => [
        for (int i = 0; i < practiceSetSizes.length; i++)
          _buildTrial(practiceSetSizes[i], 'practice-$i'),
      ];

  @override
  List<TestStimulus> buildMainStimuli() => [
        for (int i = 0; i < mainSetSizes.length; i++) _buildTrial(mainSetSizes[i], 'main-$i'),
      ];

  @override
  TestResponse evaluateResponse({
    required TestStimulus stimulus,
    required Map<String, dynamic> answer,
    required int durationMillis,
  }) {
    final int expected = stimulus.payload['targetIndex'] as int;
    final int? chosen = answer['tappedIndex'] as int?;
    return TestResponse(
      stimulus: stimulus,
      answer: answer,
      correct: chosen == expected,
      durationMillis: durationMillis,
      recordedAtEpochMs: DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  TestScoring score(List<TestResponse> responses) {
    final TestScoring base = TestScoring.fromResponses(responses);
    final Map<String, List<int>> bySetSize = {};
    for (final r in responses) {
      if (!r.correct || r.durationMillis <= 0) continue;
      final String key = (r.stimulus.payload['itemCount'] as int).toString();
      bySetSize.putIfAbsent(key, () => []).add(r.durationMillis);
    }
    final Map<String, double> meanRtBySetSize = {
      for (final entry in bySetSize.entries)
        entry.key: entry.value.reduce((a, b) => a + b) / entry.value.length,
    };
    return base.copyWith(metrics: {...base.metrics, 'meanRtBySetSize': meanRtBySetSize});
  }

  @override
  TestConfidence assessConfidence({
    required TestScoring scoring,
    required List<TestResponse> responses,
  }) {
    final ConfidenceLevel level = scoring.accuracy >= 0.7
        ? ConfidenceLevel.high
        : (scoring.accuracy >= 0.5 ? ConfidenceLevel.medium : ConfidenceLevel.low);
    return TestConfidence(
      level: level,
      score: switch (level) {
        ConfidenceLevel.high => 0.8,
        ConfidenceLevel.medium => 0.55,
        ConfidenceLevel.low => 0.3,
      },
      reasons: const ['Color-vision differences can make this search task harder.'],
    );
  }
}
