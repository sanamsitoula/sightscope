import 'package:flutter_test/flutter_test.dart';
import 'package:sightscope/core/storage/database.dart';
import 'package:sightscope/shared/models/enums.dart';
import 'package:sightscope/shared/test_engine/dummy/dummy_test_definition.dart';
import 'package:sightscope/shared/test_engine/domain/test_session_phase.dart';
import 'package:sightscope/shared/test_engine/engine/test_device_context.dart';
import 'package:sightscope/shared/test_engine/engine/test_result_repository.dart';
import 'package:sightscope/shared/test_engine/engine/test_session_controller.dart';

TestSessionController _newController(AppDatabase db) => TestSessionController(
      definition: const DummyTestDefinition(),
      deviceContext: const TestDeviceContext(
        deviceModel: 'test-device',
        screenSize: '1080x2400',
        screenDensity: 420,
        eyeTested: Eye.both,
        correctionUsed: CorrectionUsed.none,
      ),
      repository: TestResultRepository(db),
    );

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase.forTesting());
  tearDown(() => db.close());

  group('TestSessionController lifecycle', () {
    test('walks through the full phase sequence', () {
      final controller = _newController(db);
      expect(controller.state.phase, TestSessionPhase.notStarted);

      controller.start();
      expect(controller.state.phase, TestSessionPhase.introduction);

      controller.acknowledgeInstructions();
      expect(controller.state.phase, TestSessionPhase.instructions);

      controller.confirmCalibration();
      expect(controller.state.phase, TestSessionPhase.calibrationCheck);

      controller.beginPractice();
      expect(controller.state.phase, TestSessionPhase.practice);
      expect(controller.state.isPractice, isTrue);

      while (!controller.isQueueExhausted) {
        controller.recordResponse(answer: const {'choice': 0}, durationMillis: 100);
      }

      controller.beginMainTest();
      expect(controller.state.phase, TestSessionPhase.mainTest);
      expect(controller.state.isPractice, isFalse);

      while (!controller.isQueueExhausted) {
        controller.recordResponse(answer: const {'choice': 0}, durationMillis: 100);
      }

      final result = controller.score();
      expect(controller.state.phase, TestSessionPhase.result);
      expect(result.rawResponses, hasLength(6));

      controller.acknowledgeLimitations();
      controller.chooseNextStep();
      controller.complete();
      expect(controller.state.phase, TestSessionPhase.completed);
    });

    test('rejects illegal transitions', () {
      final controller = _newController(db);
      expect(
        () => controller.beginMainTest(),
        throwsA(isA<InvalidTestSessionTransition>()),
      );
    });

    test('refuses responses while paused', () {
      final controller = _newController(db);
      controller
        ..start()
        ..acknowledgeInstructions()
        ..confirmCalibration()
        ..beginPractice();
      controller.pause();
      expect(
        () => controller.recordResponse(answer: const {'choice': 0}, durationMillis: 100),
        throwsStateError,
      );
      controller.resume();
      expect(
        () => controller.recordResponse(answer: const {'choice': 0}, durationMillis: 100),
        returnsNormally,
      );
    });

    test('cancel is reachable from an in-progress session', () {
      final controller = _newController(db);
      controller.start();
      controller.cancel();
      expect(controller.state.phase, TestSessionPhase.cancelled);
    });
  });

  group('Scoring determinism', () {
    test('identical responses always produce identical scoring', () {
      final controllerA = _newController(db);
      final controllerB = _newController(db);

      for (final c in [controllerA, controllerB]) {
        c
          ..start()
          ..acknowledgeInstructions()
          ..confirmCalibration()
          ..beginPractice();
        while (!c.isQueueExhausted) {
          c.recordResponse(answer: const {'choice': 0}, durationMillis: 150);
        }
        c.beginMainTest();
        while (!c.isQueueExhausted) {
          c.recordResponse(answer: const {'choice': 0}, durationMillis: 150);
        }
      }

      final resultA = controllerA.score();
      final resultB = controllerB.score();

      expect(resultA.score, resultB.score);
      expect(resultA.accuracy, resultB.accuracy);
      expect(resultA.confidence.level, resultB.confidence.level);
    });
  });
}
