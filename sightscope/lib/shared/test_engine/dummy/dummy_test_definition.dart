import '../domain/test_confidence.dart';
import '../domain/test_definition.dart';
import '../domain/test_response.dart';
import '../domain/test_scoring.dart';
import '../domain/test_stimulus.dart';
import '../../models/enums.dart';

/// Engine-demonstration fixture (Task.md §12.4). Not a real screening test —
/// exists only to prove the engine's lifecycle end-to-end.
///
/// Stimulus payload: `{"target": <int 0..3>}`. A response is correct when
/// `answer["choice"] == target`.
class DummyTestDefinition extends TestDefinition {
  const DummyTestDefinition();

  @override
  String get id => 'dummy';

  @override
  String get version => '0.0.1';

  @override
  String get title => 'Engine Demo';

  @override
  String get shortDescription => 'Internal fixture used to validate the shared test engine.';

  static const List<int> _practiceTargets = [0, 1];
  static const List<int> _mainTargets = [0, 1, 2, 3, 1, 0];

  @override
  List<TestStimulus> buildPracticeStimuli() => _practiceTargets
      .asMap()
      .entries
      .map((e) => TestStimulus(id: 'practice-${e.key}', payload: {'target': e.value}))
      .toList();

  @override
  List<TestStimulus> buildMainStimuli() => _mainTargets
      .asMap()
      .entries
      .map((e) => TestStimulus(id: 'main-${e.key}', payload: {'target': e.value}))
      .toList();

  @override
  TestResponse evaluateResponse({
    required TestStimulus stimulus,
    required Map<String, dynamic> answer,
    required int durationMillis,
  }) {
    final int target = stimulus.payload['target'] as int;
    final int? choice = answer['choice'] as int?;
    return TestResponse(
      stimulus: stimulus,
      answer: answer,
      correct: choice == target,
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
    final ConfidenceLevel level = scoring.n >= _mainTargets.length ? ConfidenceLevel.high : ConfidenceLevel.low;
    return TestConfidence(
      level: level,
      score: scoring.n >= _mainTargets.length ? 0.9 : 0.2,
      reasons: [
        if (scoring.n >= _mainTargets.length)
          'All trials were completed.'
        else
          'Not all trials were completed.',
      ],
    );
  }
}
