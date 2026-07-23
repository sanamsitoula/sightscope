import 'dart:math';

import 'package:sightscope/shared/models/enums.dart';
import 'package:sightscope/shared/test_engine/domain/test_confidence.dart';
import 'package:sightscope/shared/test_engine/domain/test_definition.dart';
import 'package:sightscope/shared/test_engine/domain/test_response.dart';
import 'package:sightscope/shared/test_engine/domain/test_scoring.dart';
import 'package:sightscope/shared/test_engine/domain/test_stimulus.dart';

const List<int> kMemoryPalette = [0xFFE0632E, 0xFF3F6FBF, 0xFF4CAF50, 0xFFEFC94C, 0xFF9C6ADE, 0xFF35C2C1];

/// Fixed-sequence visual working-memory change-detection test
/// (research/visual_memory.md). One "same" and one "changed" trial per set
/// size, so [score] can estimate an approximate Cowan's K.
class VisualMemoryTestDefinition extends TestDefinition {
  VisualMemoryTestDefinition({Random? random}) : _random = random ?? Random();

  final Random _random;

  @override
  String get id => 'visual_memory';
  @override
  String get version => '1.0.0';
  @override
  String get title => 'Visual Memory';
  @override
  String get shortDescription => 'Screens how many colored items you can briefly remember.';

  static const List<int> mainSetSizes = [3, 4, 5];

  List<Map<String, double>> _positions(int count) {
    const int gridSize = 3;
    final List<int> cells = List.generate(gridSize * gridSize, (i) => i)..shuffle(_random);
    return [
      for (int i = 0; i < count; i++)
        {
          'dx': (cells[i] % gridSize + 0.5) / gridSize,
          'dy': (cells[i] ~/ gridSize + 0.5) / gridSize,
        },
    ];
  }

  TestStimulus _buildTrial(int setSize, bool changed, String id) {
    final List<int> colors = List.generate(
      setSize,
      (_) => kMemoryPalette[_random.nextInt(kMemoryPalette.length)],
    );
    int? changeIndex;
    int? newColor;
    if (changed) {
      changeIndex = _random.nextInt(setSize);
      final List<int> alternatives = kMemoryPalette.where((c) => c != colors[changeIndex!]).toList();
      newColor = alternatives[_random.nextInt(alternatives.length)];
    }
    return TestStimulus(
      id: id,
      payload: {
        'setSize': setSize,
        'positions': _positions(setSize),
        'studyColors': colors,
        'changed': changed,
        'changeIndex': changeIndex,
        'newColor': newColor,
      },
    );
  }

  @override
  List<TestStimulus> buildPracticeStimuli() => [_buildTrial(2, true, 'practice-0')];

  @override
  List<TestStimulus> buildMainStimuli() => [
        for (int i = 0; i < mainSetSizes.length; i++) ...[
          _buildTrial(mainSetSizes[i], false, 'main-${i}a'),
          _buildTrial(mainSetSizes[i], true, 'main-${i}b'),
        ],
      ];

  @override
  TestResponse evaluateResponse({
    required TestStimulus stimulus,
    required Map<String, dynamic> answer,
    required int durationMillis,
  }) {
    final bool changed = stimulus.payload['changed'] as bool;
    final String? response = answer['response'] as String?;
    final bool saidChanged = response == 'changed';
    return TestResponse(
      stimulus: stimulus,
      answer: answer,
      correct: saidChanged == changed,
      durationMillis: durationMillis,
      recordedAtEpochMs: DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  TestScoring score(List<TestResponse> responses) {
    final TestScoring base = TestScoring.fromResponses(responses);
    final Map<int, List<TestResponse>> bySetSize = {};
    for (final r in responses) {
      final int setSize = r.stimulus.payload['setSize'] as int;
      bySetSize.putIfAbsent(setSize, () => []).add(r);
    }
    final List<double> kEstimates = [];
    for (final entry in bySetSize.entries) {
      final List<TestResponse> trials = entry.value;
      final changedTrials = trials.where((r) => r.stimulus.payload['changed'] == true);
      final sameTrials = trials.where((r) => r.stimulus.payload['changed'] == false);
      if (changedTrials.isEmpty || sameTrials.isEmpty) continue;
      final double hitRate = changedTrials.where((r) => r.correct).length / changedTrials.length;
      final double crRate = sameTrials.where((r) => r.correct).length / sameTrials.length;
      final double k = (entry.key * (hitRate + crRate - 1)).clamp(0, entry.key.toDouble());
      kEstimates.add(k);
    }
    final double approxK =
        kEstimates.isEmpty ? 0 : kEstimates.reduce((a, b) => a + b) / kEstimates.length;
    return base.copyWith(metrics: {...base.metrics, 'approxK': approxK});
  }

  @override
  TestConfidence assessConfidence({
    required TestScoring scoring,
    required List<TestResponse> responses,
  }) {
    final ConfidenceLevel level = scoring.accuracy >= 0.7
        ? ConfidenceLevel.medium
        : ConfidenceLevel.low;
    return TestConfidence(
      level: level,
      score: level == ConfidenceLevel.medium ? 0.55 : 0.3,
      reasons: const [
        'Very few trials per set size — this estimate has wide uncertainty.',
        'This is a screening approximation, not a validated memory-span assessment.',
      ],
    );
  }
}
