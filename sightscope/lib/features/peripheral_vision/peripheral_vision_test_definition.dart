import 'dart:math';

import 'package:sightscope/shared/models/enums.dart';
import 'package:sightscope/shared/test_engine/domain/test_confidence.dart';
import 'package:sightscope/shared/test_engine/domain/test_definition.dart';
import 'package:sightscope/shared/test_engine/domain/test_response.dart';
import 'package:sightscope/shared/test_engine/domain/test_scoring.dart';
import 'package:sightscope/shared/test_engine/domain/test_stimulus.dart';

const List<String> kPeripheralQuadrants = ['right', 'up', 'left', 'down'];

/// Fixed-sequence peripheral-flash localization test
/// (research/peripheral_vision.md). Includes catch trials (no flash) to
/// flag guessing/false positives.
class PeripheralVisionTestDefinition extends TestDefinition {
  PeripheralVisionTestDefinition({Random? random}) : _random = random ?? Random();

  final Random _random;

  @override
  String get id => 'peripheral_vision';
  @override
  String get version => '1.0.0';
  @override
  String get title => 'Peripheral Awareness';
  @override
  String get shortDescription => 'Screens how reliably you notice events near the edge of vision.';

  static const int flashDurationMs = 150;
  static const int responseWindowMs = 1500;

  List<TestStimulus> _buildTrials(List<String?> quadrants, String prefix) => [
        for (int i = 0; i < quadrants.length; i++)
          TestStimulus(
            id: '$prefix-$i',
            payload: {
              'quadrant': quadrants[i],
              'preDelayMs': 800 + _random.nextInt(1200),
              'flashDurationMs': flashDurationMs,
              'responseWindowMs': responseWindowMs,
            },
          ),
      ];

  @override
  List<TestStimulus> buildPracticeStimuli() => _buildTrials(['right', 'up'], 'practice');

  @override
  List<TestStimulus> buildMainStimuli() => _buildTrials(
        ['right', 'up', 'left', 'down', 'right', 'left', null, 'down', 'up', null],
        'main',
      );

  @override
  TestResponse evaluateResponse({
    required TestStimulus stimulus,
    required Map<String, dynamic> answer,
    required int durationMillis,
  }) {
    final String? expected = stimulus.payload['quadrant'] as String?;
    final String? chosen = answer['quadrant'] as String?;
    final bool tapped = answer['tapped'] as bool? ?? false;
    final bool correct = expected == null ? !tapped : (tapped && chosen == expected);
    return TestResponse(
      stimulus: stimulus,
      answer: answer,
      correct: correct,
      durationMillis: durationMillis,
      recordedAtEpochMs: DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  TestScoring score(List<TestResponse> responses) {
    final List<TestResponse> real =
        responses.where((r) => r.stimulus.payload['quadrant'] != null).toList();
    final List<TestResponse> catchTrials =
        responses.where((r) => r.stimulus.payload['quadrant'] == null).toList();
    final int falsePositives = catchTrials.where((r) => !r.correct).length;
    final double accuracy = real.isEmpty ? 0 : real.where((r) => r.correct).length / real.length;
    final List<int> validRts =
        real.where((r) => r.correct && r.durationMillis > 0).map((r) => r.durationMillis).toList();
    final double meanRt =
        validRts.isEmpty ? 0 : validRts.reduce((a, b) => a + b) / validRts.length;
    return TestScoring(
      accuracy: accuracy,
      score: accuracy,
      meanReactionTimeMs: meanRt,
      n: responses.length,
      metrics: {'falsePositives': falsePositives},
    );
  }

  @override
  TestConfidence assessConfidence({
    required TestScoring scoring,
    required List<TestResponse> responses,
  }) {
    final int falsePositives = (scoring.metrics['falsePositives'] as int?) ?? 0;
    final ConfidenceLevel level = falsePositives > 1 ? ConfidenceLevel.low : ConfidenceLevel.medium;
    return TestConfidence(
      level: level,
      score: level == ConfidenceLevel.medium ? 0.6 : 0.3,
      reasons: [
        if (falsePositives > 1) 'Several responses occurred with no flash shown (possible guessing).',
        'This app cannot verify that you kept looking at the center dot.',
      ],
    );
  }
}
