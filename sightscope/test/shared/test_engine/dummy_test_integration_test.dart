import 'package:flutter_test/flutter_test.dart';
import 'package:sightscope/core/storage/database.dart';
import 'package:sightscope/shared/models/enums.dart';
import 'package:sightscope/shared/test_engine/dummy/dummy_test_definition.dart';
import 'package:sightscope/shared/test_engine/engine/test_device_context.dart';
import 'package:sightscope/shared/test_engine/engine/test_result_repository.dart';
import 'package:sightscope/shared/test_engine/engine/test_session_controller.dart';

void main() {
  test('dummy test runs end-to-end through the engine and the result reloads from Drift', () async {
    final db = AppDatabase.forTesting();
    addTearDown(db.close);
    final repository = TestResultRepository(db);

    final controller = TestSessionController(
      definition: const DummyTestDefinition(),
      deviceContext: const TestDeviceContext(
        deviceModel: 'pixel-test',
        screenSize: '1080x2400',
        screenDensity: 420,
        viewingDistanceMm: 400,
        eyeTested: Eye.both,
        correctionUsed: CorrectionUsed.none,
        environmentNotes: 'indoor, even lighting',
      ),
      repository: repository,
    );

    controller.start();
    controller.acknowledgeInstructions();
    controller.confirmCalibration();

    controller.beginPractice();
    while (!controller.isQueueExhausted) {
      controller.recordResponse(answer: const {'choice': 0}, durationMillis: 120);
    }

    controller.beginMainTest();
    while (!controller.isQueueExhausted) {
      controller.recordResponse(answer: const {'choice': 0}, durationMillis: 120);
    }

    final result = controller.score();
    controller.acknowledgeLimitations();
    controller.chooseNextStep();
    controller.complete();

    await controller.persist();

    final reloaded = await repository.loadById(result.sessionId!);
    expect(reloaded, isNotNull);
    expect(reloaded!.testId, 'dummy');
    expect(reloaded.score, result.score);
    expect(reloaded.accuracy, result.accuracy);
    expect(reloaded.rawResponses.length, result.rawResponses.length);
    expect(reloaded.confidence.level, result.confidence.level);
    expect(reloaded.deviceModel, 'pixel-test');
    expect(reloaded.environmentNotes, 'indoor, even lighting');
  });
}
