import 'package:freezed_annotation/freezed_annotation.dart';

import 'test_result.dart';
import 'test_session_phase.dart';
import 'test_stimulus.dart';

part 'test_session_state.freezed.dart';

/// Ephemeral state of a test session (not persisted; reconstructed on resume
/// from persisted [TestResult] + the test definition).
@freezed
abstract class TestSessionState with _$TestSessionState {
  const factory TestSessionState({
    @Default(TestSessionPhase.notStarted) TestSessionPhase phase,
    @Default(<String>[]) List<String> log,
    TestStimulus? currentStimulus,
    @Default(false) bool isPractice,
    TestResult? result,
  }) = _TestSessionState;

  const TestSessionState._();

  bool get isTerminal =>
      phase == TestSessionPhase.completed || phase == TestSessionPhase.cancelled;
}
