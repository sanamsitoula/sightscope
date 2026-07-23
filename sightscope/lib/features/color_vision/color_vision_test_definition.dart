import 'package:sightscope/shared/models/enums.dart';
import 'package:sightscope/shared/test_engine/domain/test_confidence.dart';
import 'package:sightscope/shared/test_engine/domain/test_definition.dart';
import 'package:sightscope/shared/test_engine/domain/test_response.dart';
import 'package:sightscope/shared/test_engine/domain/test_scoring.dart';
import 'package:sightscope/shared/test_engine/domain/test_stimulus.dart';

/// Fixed-sequence (non-adaptive) color-vision screening plates
/// (research/color_perception.md). Not a staircase — a fixed easy→subtle
/// plate sequence, each independently scored.
class ColorVisionTestDefinition extends TestDefinition {
  const ColorVisionTestDefinition();

  @override
  String get id => 'color_vision';
  @override
  String get version => '1.0.0';
  @override
  String get title => 'Color Perception';
  @override
  String get shortDescription =>
      'Screens for possible differences in red-green color perception using original plates.';

  // (shape, colorDistance) — colorDistance 1.0 = easy, lower = subtler.
  static const List<(String, double)> _practicePlates = [('circle', 1.0)];
  static const List<(String, double)> _mainPlates = [
    ('circle', 0.9),
    ('square', 0.7),
    ('triangle', 0.55),
    ('circle', 0.35),
    ('square', 0.2),
  ];

  List<TestStimulus> _build(List<(String, double)> plates, String prefix) => [
        for (int i = 0; i < plates.length; i++)
          TestStimulus(
            id: '$prefix-$i',
            payload: {'shape': plates[i].$1, 'colorDistance': plates[i].$2, 'seed': i * 7919 + 13},
          ),
      ];

  @override
  List<TestStimulus> buildPracticeStimuli() => _build(_practicePlates, 'practice');

  @override
  List<TestStimulus> buildMainStimuli() => _build(_mainPlates, 'main');

  @override
  TestResponse evaluateResponse({
    required TestStimulus stimulus,
    required Map<String, dynamic> answer,
    required int durationMillis,
  }) {
    final String expected = stimulus.payload['shape'] as String;
    final String? chosen = answer['shape'] as String?;
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
    final List<TestResponse> subtle = responses.length >= 2
        ? responses.sublist(responses.length - 2)
        : responses;
    final double subtleAccuracy =
        subtle.isEmpty ? 0 : subtle.where((r) => r.correct).length / subtle.length;
    return base.copyWith(metrics: {...base.metrics, 'subtleAccuracy': subtleAccuracy});
  }

  @override
  TestConfidence assessConfidence({
    required TestScoring scoring,
    required List<TestResponse> responses,
  }) {
    return const TestConfidence(
      level: ConfidenceLevel.medium,
      score: 0.5,
      reasons: [
        'This is a screening flag, not a diagnostic color-vision test.',
        'Display color rendering varies significantly by device.',
      ],
    );
  }
}
