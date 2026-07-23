import 'dart:math';

import 'package:sightscope/shared/models/enums.dart';
import 'package:sightscope/shared/test_engine/domain/test_confidence.dart';
import 'package:sightscope/shared/test_engine/domain/test_definition.dart';
import 'package:sightscope/shared/test_engine/domain/test_response.dart';
import 'package:sightscope/shared/test_engine/domain/test_scoring.dart';
import 'package:sightscope/shared/test_engine/domain/test_stimulus.dart';

/// Fixed-sequence pictorial-depth-cue (relative size + occlusion) test
/// (research/stereo_depth.md). Explicitly NOT a binocular stereoacuity
/// test — a single flat display cannot present binocular disparity.
class DepthPerceptionTestDefinition extends TestDefinition {
  DepthPerceptionTestDefinition({Random? random}) : _random = random ?? Random();

  final Random _random;

  @override
  String get id => 'depth_perception';
  @override
  String get version => '1.0.0';
  @override
  String get title => 'Depth Perception';
  @override
  String get shortDescription =>
      'Screens depth-cue judgment from on-screen visual cues (not binocular stereo).';

  static const List<double> mainStrengths = [0.9, 0.7, 0.5, 0.35, 0.25, 0.15];

  List<TestStimulus> _build(List<double> strengths, String prefix) => [
        for (int i = 0; i < strengths.length; i++)
          TestStimulus(
            id: '$prefix-$i',
            payload: {
              'strength': strengths[i],
              'nearIsLeft': _random.nextBool(),
            },
          ),
      ];

  @override
  List<TestStimulus> buildPracticeStimuli() => _build([0.9], 'practice');

  @override
  List<TestStimulus> buildMainStimuli() => _build(mainStrengths, 'main');

  @override
  TestResponse evaluateResponse({
    required TestStimulus stimulus,
    required Map<String, dynamic> answer,
    required int durationMillis,
  }) {
    final bool nearIsLeft = stimulus.payload['nearIsLeft'] as bool;
    final String? choice = answer['choice'] as String?;
    final bool correct = (choice == 'left') == nearIsLeft;
    return TestResponse(
      stimulus: stimulus,
      answer: answer,
      correct: correct,
      durationMillis: durationMillis,
      recordedAtEpochMs: DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  TestScoring score(List<TestResponse> responses) => TestScoring.fromResponses(responses);

  @override
  TestConfidence assessConfidence({
    required TestScoring scoring,
    required List<TestResponse> responses,
  }) {
    return const TestConfidence(
      level: ConfidenceLevel.medium,
      score: 0.5,
      reasons: [
        'This screens pictorial depth cues, not true binocular stereo depth — a flat screen '
            'cannot present binocular disparity.',
      ],
    );
  }
}
