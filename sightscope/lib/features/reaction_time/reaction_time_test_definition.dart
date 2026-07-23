import 'dart:math';

import 'package:sightscope/shared/models/enums.dart';
import 'package:sightscope/shared/test_engine/domain/test_confidence.dart';
import 'package:sightscope/shared/test_engine/domain/test_definition.dart';
import 'package:sightscope/shared/test_engine/domain/test_response.dart';
import 'package:sightscope/shared/test_engine/domain/test_scoring.dart';
import 'package:sightscope/shared/test_engine/domain/test_stimulus.dart';

/// Simple visual reaction-time test (research/reaction_time.md). v1.0.0:
/// fixed-length trial set, randomized inter-stimulus interval, no catch
/// trials yet (see research doc limitations note).
class ReactionTimeTestDefinition extends TestDefinition {
  ReactionTimeTestDefinition({Random? random}) : _random = random ?? Random();

  final Random _random;

  @override
  String get id => 'reaction_time';
  @override
  String get version => '1.0.0';
  @override
  String get title => 'Reaction Time';
  @override
  String get shortDescription => 'Screens simple visual-motor reaction speed.';

  static const int practiceTrialCount = 3;
  static const int mainTrialCount = 8;
  static const int minDelayMs = 1200;
  static const int maxDelayMs = 3200;

  List<TestStimulus> _buildTrials(int count, String prefix) => [
        for (int i = 0; i < count; i++)
          TestStimulus(
            id: '$prefix-$i',
            payload: {'delayMs': minDelayMs + _random.nextInt(maxDelayMs - minDelayMs)},
          ),
      ];

  @override
  List<TestStimulus> buildPracticeStimuli() => _buildTrials(practiceTrialCount, 'practice');

  @override
  List<TestStimulus> buildMainStimuli() => _buildTrials(mainTrialCount, 'main');

  @override
  TestResponse evaluateResponse({
    required TestStimulus stimulus,
    required Map<String, dynamic> answer,
    required int durationMillis,
  }) {
    final bool falseStart = answer['falseStart'] as bool? ?? false;
    return TestResponse(
      stimulus: stimulus,
      answer: answer,
      correct: !falseStart,
      durationMillis: durationMillis,
      recordedAtEpochMs: DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  TestScoring score(List<TestResponse> responses) {
    final List<TestResponse> valid =
        responses.where((r) => r.correct && r.durationMillis > 0).toList();
    final int falseStarts = responses.where((r) => !r.correct).length;
    final double meanRt = valid.isEmpty
        ? 0
        : valid.map((r) => r.durationMillis).reduce((a, b) => a + b) / valid.length;
    return TestScoring(
      accuracy: responses.isEmpty ? 0 : valid.length / responses.length,
      score: meanRt,
      meanReactionTimeMs: meanRt,
      n: responses.length,
      metrics: {'falseStarts': falseStarts, 'validTrials': valid.length},
    );
  }

  @override
  TestConfidence assessConfidence({
    required TestScoring scoring,
    required List<TestResponse> responses,
  }) {
    final int validTrials = (scoring.metrics['validTrials'] as int?) ?? 0;
    final int falseStarts = (scoring.metrics['falseStarts'] as int?) ?? 0;
    final ConfidenceLevel level =
        (validTrials >= 6 && falseStarts <= 1) ? ConfidenceLevel.high : (validTrials >= 4 ? ConfidenceLevel.medium : ConfidenceLevel.low);
    return TestConfidence(
      level: level,
      score: switch (level) {
        ConfidenceLevel.high => 0.8,
        ConfidenceLevel.medium => 0.55,
        ConfidenceLevel.low => 0.3,
      },
      reasons: [
        if (falseStarts > 1) 'Several responses looked like early/anticipatory taps.',
        'Device touch-input latency varies and is not calibrated out of this result.',
      ],
    );
  }
}
