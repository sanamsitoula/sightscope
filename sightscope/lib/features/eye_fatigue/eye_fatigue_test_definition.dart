import 'package:sightscope/shared/models/enums.dart';
import 'package:sightscope/shared/test_engine/domain/test_confidence.dart';
import 'package:sightscope/shared/test_engine/domain/test_definition.dart';
import 'package:sightscope/shared/test_engine/domain/test_response.dart';
import 'package:sightscope/shared/test_engine/domain/test_scoring.dart';
import 'package:sightscope/shared/test_engine/domain/test_stimulus.dart';

/// Self-report digital eye-strain symptom questionnaire
/// (research/eye_fatigue.md). Not a performance test — there is no
/// "correct" answer, so [evaluateResponse] always marks responses correct
/// and scoring is the mean item rating.
class EyeFatigueTestDefinition extends TestDefinition {
  const EyeFatigueTestDefinition();

  @override
  String get id => 'eye_fatigue';
  @override
  String get version => '1.0.0';
  @override
  String get title => 'Eye Fatigue Questionnaire';
  @override
  String get shortDescription => 'A brief self-report of recent digital eye-strain symptoms.';

  static const List<String> questions = [
    'How often have your eyes felt strained after screen use?',
    'How often have your eyes felt dry or irritated?',
    'How often has your vision felt blurred after screen use?',
    'How often have you had headaches you associate with screen use?',
    'How often have you had difficulty focusing after extended screen use?',
  ];

  @override
  List<TestStimulus> buildPracticeStimuli() => const <TestStimulus>[];

  @override
  List<TestStimulus> buildMainStimuli() => [
        for (int i = 0; i < questions.length; i++)
          TestStimulus(id: 'q-$i', payload: {'question': questions[i]}),
      ];

  @override
  TestResponse evaluateResponse({
    required TestStimulus stimulus,
    required Map<String, dynamic> answer,
    required int durationMillis,
  }) {
    return TestResponse(
      stimulus: stimulus,
      answer: answer,
      correct: true,
      durationMillis: durationMillis,
      recordedAtEpochMs: DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  TestScoring score(List<TestResponse> responses) {
    final List<int> ratings = responses.map((r) => r.answer['rating'] as int).toList();
    final double mean = ratings.isEmpty ? 0 : ratings.reduce((a, b) => a + b) / ratings.length;
    return TestScoring(
      accuracy: 1.0,
      score: mean,
      n: responses.length,
      metrics: {'itemScores': ratings},
    );
  }

  @override
  TestConfidence assessConfidence({
    required TestScoring scoring,
    required List<TestResponse> responses,
  }) {
    return const TestConfidence(
      level: ConfidenceLevel.medium,
      score: 0.5,
      reasons: ['This is a subjective self-report, not a validated clinical questionnaire.'],
    );
  }
}
