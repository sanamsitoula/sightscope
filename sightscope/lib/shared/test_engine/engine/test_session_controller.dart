import 'dart:math';

import '../domain/test_definition.dart';
import '../domain/test_response.dart';
import '../domain/test_result.dart';
import '../domain/test_session_phase.dart';
import '../domain/test_session_state.dart';
import '../domain/test_stimulus.dart';
import 'test_device_context.dart';
import 'test_result_repository.dart';

/// Legal phase transitions (Task.md §11 lifecycle).
const Map<TestSessionPhase, Set<TestSessionPhase>> _kTransitions = {
  TestSessionPhase.notStarted: {TestSessionPhase.introduction, TestSessionPhase.cancelled},
  TestSessionPhase.introduction: {TestSessionPhase.instructions, TestSessionPhase.cancelled},
  TestSessionPhase.instructions: {TestSessionPhase.calibrationCheck, TestSessionPhase.cancelled},
  TestSessionPhase.calibrationCheck: {TestSessionPhase.practice, TestSessionPhase.cancelled},
  TestSessionPhase.practice: {
    TestSessionPhase.practice,
    TestSessionPhase.mainTest,
    TestSessionPhase.cancelled,
  },
  TestSessionPhase.mainTest: {
    TestSessionPhase.mainTest,
    TestSessionPhase.scoring,
    TestSessionPhase.cancelled,
  },
  TestSessionPhase.scoring: {TestSessionPhase.confidence, TestSessionPhase.cancelled},
  TestSessionPhase.confidence: {TestSessionPhase.result, TestSessionPhase.cancelled},
  TestSessionPhase.result: {TestSessionPhase.limitations, TestSessionPhase.cancelled},
  TestSessionPhase.limitations: {TestSessionPhase.nextStep, TestSessionPhase.cancelled},
  TestSessionPhase.nextStep: {TestSessionPhase.completed, TestSessionPhase.cancelled},
  TestSessionPhase.completed: {},
  TestSessionPhase.cancelled: {},
};

/// Thrown when an engine method is called from an illegal [TestSessionPhase].
class InvalidTestSessionTransition implements Exception {
  InvalidTestSessionTransition(this.from, this.to);
  final TestSessionPhase from;
  final TestSessionPhase to;

  @override
  String toString() => 'InvalidTestSessionTransition: $from -> $to is not allowed';
}

/// The shared engine every SightScope test runs through (Task.md §11).
///
/// A test never implements its own session lifecycle — it supplies a
/// [TestDefinition] and drives this controller.
class TestSessionController {
  TestSessionController({
    required this.definition,
    required this.deviceContext,
    required TestResultRepository repository,
    String? sessionId,
    Random? random,
  })  : _repository = repository,
        sessionId = sessionId ?? _generateSessionId(random ?? Random());

  final TestDefinition definition;
  final TestDeviceContext deviceContext;
  final TestResultRepository _repository;
  final String sessionId;

  TestSessionState _state = const TestSessionState();
  TestSessionState get state => _state;

  final List<TestResponse> _practiceResponses = <TestResponse>[];
  final List<TestResponse> _mainResponses = <TestResponse>[];
  List<TestResponse> get mainResponses => List.unmodifiable(_mainResponses);

  List<TestStimulus> _queue = const <TestStimulus>[];
  int _queueIndex = 0;

  static String _generateSessionId(Random random) {
    final int a = random.nextInt(1 << 32);
    final int b = random.nextInt(1 << 32);
    return '${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}-'
        '${a.toRadixString(36)}${b.toRadixString(36)}';
  }

  void _transitionTo(TestSessionPhase next) {
    final Set<TestSessionPhase> allowed = _kTransitions[_state.phase] ?? const {};
    if (!allowed.contains(next)) {
      throw InvalidTestSessionTransition(_state.phase, next);
    }
    _state = _state.copyWith(phase: next);
  }

  void start() {
    _transitionTo(TestSessionPhase.introduction);
    _state = _state.copyWith(log: [..._state.log, 'started']);
  }

  void acknowledgeInstructions() => _transitionTo(TestSessionPhase.instructions);

  void confirmCalibration() => _transitionTo(TestSessionPhase.calibrationCheck);

  /// Enter (or re-enter) the practice phase and load its stimulus queue.
  void beginPractice() {
    if (_state.phase != TestSessionPhase.practice) {
      _transitionTo(TestSessionPhase.practice);
    }
    _queue = definition.buildPracticeStimuli();
    _queueIndex = 0;
    _state = _state.copyWith(
      isPractice: true,
      currentStimulus: _queue.isEmpty ? null : _queue.first,
    );
  }

  void beginMainTest() {
    _transitionTo(TestSessionPhase.mainTest);
    _queue = definition.buildMainStimuli();
    _queueIndex = 0;
    _state = _state.copyWith(
      isPractice: false,
      currentStimulus: _queue.isEmpty ? null : _queue.first,
    );
  }

  /// Record a response to the current stimulus and advance the queue.
  ///
  /// Practice responses are evaluated but never scored or persisted.
  TestResponse recordResponse({
    required Map<String, dynamic> answer,
    required int durationMillis,
  }) {
    if (_paused) {
      throw StateError('Cannot record a response while the session is paused.');
    }
    final TestStimulus? stimulus = _state.currentStimulus;
    if (stimulus == null) {
      throw StateError('No current stimulus to respond to.');
    }
    final TestResponse response = definition.evaluateResponse(
      stimulus: stimulus,
      answer: answer,
      durationMillis: durationMillis,
    );
    if (_state.isPractice) {
      _practiceResponses.add(response);
    } else {
      _mainResponses.add(response);
    }

    _queueIndex++;
    final TestStimulus? next = _queueIndex < _queue.length ? _queue[_queueIndex] : null;
    _state = _state.copyWith(currentStimulus: next);
    return response;
  }

  bool get isQueueExhausted => _state.currentStimulus == null;

  bool _paused = false;
  bool get isPaused => _paused;

  /// Suspend the session in place. The engine keeps its in-memory queue and
  /// responses; [recordResponse] is refused until [resume] is called.
  void pause() => _paused = true;

  void resume() => _paused = false;

  /// Score the main-phase responses and produce the (unsaved) [TestResult].
  TestResult score() {
    _transitionTo(TestSessionPhase.scoring);
    final scoring = definition.score(_mainResponses);
    _transitionTo(TestSessionPhase.confidence);
    final confidence = definition.assessConfidence(scoring: scoring, responses: _mainResponses);
    _transitionTo(TestSessionPhase.result);

    final result = TestResult(
      testId: definition.id,
      testVersion: definition.version,
      date: DateTime.now(),
      deviceModel: deviceContext.deviceModel,
      screenSize: deviceContext.screenSize,
      screenDensity: deviceContext.screenDensity,
      brightnessIfAvailable: deviceContext.brightnessIfAvailable,
      viewingDistance: deviceContext.viewingDistanceMm,
      eyeTested: deviceContext.eyeTested,
      correctionUsed: deviceContext.correctionUsed,
      rawResponses: List.unmodifiable(_mainResponses),
      scoring: scoring,
      confidence: confidence,
      environmentNotes: deviceContext.environmentNotes,
      sessionId: sessionId,
    );
    _state = _state.copyWith(result: result);
    return result;
  }

  void acknowledgeLimitations() => _transitionTo(TestSessionPhase.limitations);

  void chooseNextStep() => _transitionTo(TestSessionPhase.nextStep);

  void complete() => _transitionTo(TestSessionPhase.completed);

  void cancel() => _transitionTo(TestSessionPhase.cancelled);

  /// Persist the scored [TestResult] via the shared repository (Drift only).
  Future<void> persist() async {
    final TestResult? result = _state.result;
    if (result == null) {
      throw StateError('Cannot persist before score() has produced a result.');
    }
    await _repository.save(result);
  }
}
