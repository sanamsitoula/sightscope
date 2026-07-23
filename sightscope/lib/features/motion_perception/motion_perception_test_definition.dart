import 'dart:math';

import 'package:sightscope/shared/models/enums.dart';
import 'package:sightscope/shared/test_engine/domain/test_confidence.dart';
import 'package:sightscope/shared/test_engine/domain/test_definition.dart';
import 'package:sightscope/shared/test_engine/domain/test_response.dart';
import 'package:sightscope/shared/test_engine/domain/test_scoring.dart';
import 'package:sightscope/shared/test_engine/domain/test_stimulus.dart';
import 'package:sightscope/shared/test_engine/engine/staircase.dart';

/// Adaptive coherent-motion (random-dot kinematogram) direction-
/// discrimination test (research/motion_perception.md).
class MotionPerceptionTestDefinition extends TestDefinition {
  MotionPerceptionTestDefinition({Random? random}) : _random = random ?? Random();

  final Random _random;

  @override
  String get id => 'motion_perception';
  @override
  String get version => '1.0.0';
  @override
  String get title => 'Motion Perception';
  @override
  String get shortDescription => 'Screens sensitivity to coherent visual motion.';

  static const StaircaseConfig practiceConfig = StaircaseConfig(
    startLevel: 0.7,
    stepSize: 0.15,
    minLevel: 0.05,
    maxLevel: 1.0,
    reversalsToTerminate: 2,
    maxTrials: 6,
  );

  static const StaircaseConfig mainConfig = StaircaseConfig(
    startLevel: 0.5,
    stepSize: 0.1,
    minLevel: 0.05,
    maxLevel: 1.0,
    reversalsToTerminate: 4,
    maxTrials: 14,
  );

  Staircase? _practiceStaircase;
  Staircase? _mainStaircase;

  Staircase get mainStaircase => _mainStaircase ??= Staircase(mainConfig);

  @override
  bool get isAdaptive => true;

  @override
  List<TestStimulus> buildPracticeStimuli() => const <TestStimulus>[];

  @override
  List<TestStimulus> buildMainStimuli() => const <TestStimulus>[];

  @override
  TestStimulus? nextAdaptiveStimulus({
    required bool isPractice,
    required List<TestResponse> responsesSoFar,
  }) {
    final Staircase staircase =
        isPractice ? (_practiceStaircase ??= Staircase(practiceConfig)) : mainStaircase;
    if (responsesSoFar.isNotEmpty) {
      staircase.recordResponse(responsesSoFar.last.correct);
    }
    if (staircase.isDone) return null;

    final String direction = _random.nextBool() ? 'left' : 'right';
    return TestStimulus(
      id: '${isPractice ? 'practice' : 'main'}-${responsesSoFar.length}',
      payload: {
        'coherence': staircase.level,
        'direction': direction,
        'seed': _random.nextInt(1 << 30),
      },
    );
  }

  @override
  TestResponse evaluateResponse({
    required TestStimulus stimulus,
    required Map<String, dynamic> answer,
    required int durationMillis,
  }) {
    final String expected = stimulus.payload['direction'] as String;
    final String? chosen = answer['direction'] as String?;
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
    final double coherenceThreshold = mainStaircase.threshold;
    final TestScoring base = TestScoring.fromResponses(responses);
    return base.copyWith(
      score: coherenceThreshold,
      metrics: {
        ...base.metrics,
        'coherenceThreshold': coherenceThreshold,
        'reversals': mainStaircase.reversalLevels.length,
      },
    );
  }

  @override
  TestConfidence assessConfidence({
    required TestScoring scoring,
    required List<TestResponse> responses,
  }) {
    final int reversals = (scoring.metrics['reversals'] as int?) ?? 0;
    final ConfidenceLevel level = reversals >= mainConfig.reversalsToTerminate
        ? ConfidenceLevel.high
        : (reversals >= 2 ? ConfidenceLevel.medium : ConfidenceLevel.low);
    return TestConfidence(
      level: level,
      score: switch (level) {
        ConfidenceLevel.high => 0.8,
        ConfidenceLevel.medium => 0.55,
        ConfidenceLevel.low => 0.3,
      },
      reasons: [
        if (reversals < mainConfig.reversalsToTerminate)
          'The staircase did not reach its full reversal count.',
        'Screen refresh rate and frame timing can affect this result.',
      ],
    );
  }
}
