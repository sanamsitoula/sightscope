import 'package:flutter_test/flutter_test.dart';
import 'package:sightscope/core/storage/database.dart';
import 'package:sightscope/features/visual_acuity/acuity_test_definition.dart';
import 'package:sightscope/shared/models/enums.dart';
import 'package:sightscope/shared/test_engine/engine/test_device_context.dart';
import 'package:sightscope/shared/test_engine/engine/test_result_repository.dart';
import 'package:sightscope/shared/test_engine/engine/test_session_controller.dart';

void main() {
  test('full visual-acuity session runs end-to-end, persists, and reloads', () async {
    final db = AppDatabase.forTesting();
    addTearDown(db.close);
    final repository = TestResultRepository(db);

    final controller = TestSessionController(
      definition: AcuityTestDefinition(
        id: 'visual_acuity',
        version: '1.0.0',
        title: 'Visual Acuity',
        shortDescription: 'test',
        viewingDistanceMm: 400,
        ppi: 400,
      ),
      deviceContext: const TestDeviceContext(
        deviceModel: 'pixel-test',
        screenSize: '1080x2400',
        screenDensity: 400,
        viewingDistanceMm: 400,
        eyeTested: Eye.right,
        correctionUsed: CorrectionUsed.glasses,
      ),
      repository: repository,
    );

    controller.start();
    controller.acknowledgeInstructions();
    controller.confirmCalibration();

    controller.beginPractice();
    while (!controller.isQueueExhausted) {
      controller.recordResponse(
        answer: {'orientation': controller.state.currentStimulus!.payload['orientation']},
        durationMillis: 400,
      );
    }

    controller.beginMainTest();
    while (!controller.isQueueExhausted) {
      controller.recordResponse(
        answer: {'orientation': controller.state.currentStimulus!.payload['orientation']},
        durationMillis: 400,
      );
    }

    final result = controller.score();
    expect(result.testId, 'visual_acuity');
    expect(result.scoring.metrics['logMAR'], isNotNull);
    expect(result.confidence.level.name, isNotEmpty);

    controller.acknowledgeLimitations();
    controller.chooseNextStep();
    controller.complete();
    await controller.persist();

    final reloaded = await repository.loadById(result.sessionId!);
    expect(reloaded, isNotNull);
    expect(reloaded!.scoring.metrics['logMAR'], result.scoring.metrics['logMAR']);
  });

  test('a visual-acuity session can be interrupted mid-test and resumed', () {
    final db = AppDatabase.forTesting();
    addTearDown(db.close);
    final repository = TestResultRepository(db);

    final controller = TestSessionController(
      definition: AcuityTestDefinition(
        id: 'visual_acuity',
        version: '1.0.0',
        title: 'Visual Acuity',
        shortDescription: 'test',
        viewingDistanceMm: 400,
        ppi: 400,
      ),
      deviceContext: const TestDeviceContext(
        deviceModel: 'pixel-test',
        screenSize: '1080x2400',
        screenDensity: 400,
        eyeTested: Eye.left,
        correctionUsed: CorrectionUsed.none,
      ),
      repository: repository,
    );

    controller.start();
    controller.acknowledgeInstructions();
    controller.confirmCalibration();
    controller.beginPractice();
    while (!controller.isQueueExhausted) {
      controller.recordResponse(
        answer: {'orientation': controller.state.currentStimulus!.payload['orientation']},
        durationMillis: 200,
      );
    }
    controller.beginMainTest();

    // Answer a couple of main trials, then interrupt.
    for (int i = 0; i < 2 && !controller.isQueueExhausted; i++) {
      controller.recordResponse(
        answer: {'orientation': controller.state.currentStimulus!.payload['orientation']},
        durationMillis: 200,
      );
    }
    final stimulusBeforePause = controller.state.currentStimulus;
    controller.pause();
    expect(controller.isPaused, isTrue);
    expect(
      () => controller.recordResponse(answer: const {'orientation': 0}, durationMillis: 200),
      throwsStateError,
    );

    // Resume and confirm the session picks up exactly where it left off.
    controller.resume();
    expect(controller.isPaused, isFalse);
    expect(controller.state.currentStimulus, stimulusBeforePause);

    while (!controller.isQueueExhausted) {
      controller.recordResponse(
        answer: {'orientation': controller.state.currentStimulus!.payload['orientation']},
        durationMillis: 200,
      );
    }
    final result = controller.score();
    expect(result.rawResponses, isNotEmpty);
  });
}
