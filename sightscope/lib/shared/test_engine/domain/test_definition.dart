import 'test_confidence.dart';
import 'test_response.dart';
import 'test_scoring.dart';
import 'test_stimulus.dart';

/// The contract every SightScope test implements (Task.md §11).
///
/// A [TestDefinition] owns its stimulus generation, response evaluation, and
/// scoring. It never manages session lifecycle directly — that is the shared
/// engine's job ([TestSessionController]).
abstract class TestDefinition {
  const TestDefinition();

  /// Stable identifier, e.g. "dummy" or "visual_acuity.tumbling_e".
  String get id;

  /// Semver of this test's protocol. Bump when scoring/protocol changes.
  String get version;

  String get title;

  String get shortDescription;

  /// Stimuli shown during the practice phase (may be empty).
  List<TestStimulus> buildPracticeStimuli();

  /// Stimuli shown during the main (scored) phase.
  List<TestStimulus> buildMainStimuli();

  /// Judge a single answer against its stimulus. Must be pure/deterministic.
  TestResponse evaluateResponse({
    required TestStimulus stimulus,
    required Map<String, dynamic> answer,
    required int durationMillis,
  });

  /// Deterministic scoring over the main-phase responses only.
  TestScoring score(List<TestResponse> responses);

  /// Confidence for this result. Deterministic given [scoring]/[responses].
  TestConfidence assessConfidence({
    required TestScoring scoring,
    required List<TestResponse> responses,
  });
}
