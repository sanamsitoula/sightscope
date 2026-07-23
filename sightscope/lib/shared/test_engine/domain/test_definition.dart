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

  /// Whether this test drives its own stimulus sequence trial-by-trial
  /// (e.g. an adaptive staircase) instead of a fixed pre-built queue.
  ///
  /// When true, the engine ignores [buildPracticeStimuli]/[buildMainStimuli]
  /// and calls [nextAdaptiveStimulus] after every response.
  bool get isAdaptive => false;

  /// Stimuli shown during the practice phase (may be empty). Ignored when
  /// [isAdaptive] is true.
  List<TestStimulus> buildPracticeStimuli();

  /// Stimuli shown during the main (scored) phase. Ignored when [isAdaptive]
  /// is true.
  List<TestStimulus> buildMainStimuli();

  /// For adaptive tests only: the next stimulus given the responses
  /// recorded so far in the current phase, or `null` when this test's own
  /// stopping rule (e.g. staircase reversal count) has been met.
  TestStimulus? nextAdaptiveStimulus({
    required bool isPractice,
    required List<TestResponse> responsesSoFar,
  }) =>
      throw UnsupportedError('nextAdaptiveStimulus is only used when isAdaptive is true.');

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
