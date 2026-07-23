import 'package:flutter_test/flutter_test.dart';
import 'package:sightscope/core/storage/database.dart';
import 'package:sightscope/features/eye_fatigue/eye_fatigue_test_definition.dart';
import 'package:sightscope/features/peripheral_vision/peripheral_vision_test_definition.dart';
import 'package:sightscope/features/trends/trend_calculator.dart';
import 'package:sightscope/features/visual_attention/visual_attention_test_definition.dart';
import 'package:sightscope/shared/models/enums.dart';
import 'package:sightscope/shared/test_engine/engine/test_device_context.dart';
import 'package:sightscope/shared/test_engine/engine/test_result_repository.dart';
import 'package:sightscope/shared/test_engine/engine/test_session_controller.dart';

const TestDeviceContext _kDevice = TestDeviceContext(
  deviceModel: 'pixel-test',
  screenSize: '1080x2400',
  screenDensity: 400,
  eyeTested: Eye.both,
  correctionUsed: CorrectionUsed.unknown,
);

Future<void> _runFixedQueueSession(
  TestSessionController controller,
  Map<String, dynamic> Function(String testId, Map<String, dynamic> payload) answerFor,
) async {
  controller.start();
  controller.acknowledgeInstructions();
  controller.confirmCalibration();
  controller.beginPractice();
  while (!controller.isQueueExhausted) {
    final stimulus = controller.state.currentStimulus!;
    controller.recordResponse(
      answer: answerFor(controller.definition.id, stimulus.payload),
      durationMillis: 100,
    );
  }
  controller.beginMainTest();
  while (!controller.isQueueExhausted) {
    final stimulus = controller.state.currentStimulus!;
    controller.recordResponse(
      answer: answerFor(controller.definition.id, stimulus.payload),
      durationMillis: 100,
    );
  }
  controller.score();
  controller.acknowledgeLimitations();
  controller.chooseNextStep();
  controller.complete();
  await controller.persist();
}

void main() {
  test('a multi-test session persists each dimension separately, never combined into one score', () async {
    final db = AppDatabase.forTesting();
    addTearDown(db.close);
    final repository = TestResultRepository(db);

    // Eye Fatigue: self-report, "correct" is always true; rating is what matters.
    final eyeFatigue = TestSessionController(
      definition: const EyeFatigueTestDefinition(),
      deviceContext: _kDevice,
      repository: repository,
    );
    eyeFatigue.start();
    eyeFatigue.acknowledgeInstructions();
    eyeFatigue.confirmCalibration();
    eyeFatigue.beginPractice();
    eyeFatigue.beginMainTest();
    while (!eyeFatigue.isQueueExhausted) {
      eyeFatigue.recordResponse(answer: const {'rating': 2}, durationMillis: 0);
    }
    eyeFatigue.score();
    eyeFatigue.acknowledgeLimitations();
    eyeFatigue.chooseNextStep();
    eyeFatigue.complete();
    await eyeFatigue.persist();

    // Peripheral vision: answer every real trial correctly, withhold on catch trials.
    final peripheral = TestSessionController(
      definition: PeripheralVisionTestDefinition(),
      deviceContext: _kDevice,
      repository: repository,
    );
    await _runFixedQueueSession(peripheral, (testId, payload) {
      final String? quadrant = payload['quadrant'] as String?;
      return {'quadrant': quadrant, 'tapped': quadrant != null};
    });

    // Visual attention: always tap the actual target index.
    final attention = TestSessionController(
      definition: VisualAttentionTestDefinition(),
      deviceContext: _kDevice,
      repository: repository,
    );
    await _runFixedQueueSession(attention, (testId, payload) {
      return {'tappedIndex': payload['targetIndex']};
    });

    final all = await repository.loadAll();
    expect(all.map((r) => r.testId).toSet(), {'eye_fatigue', 'peripheral_vision', 'visual_attention'});

    final grouped = TrendCalculator.groupByTestId(all);
    expect(grouped.keys.length, 3);
    // Each dimension's score stands alone — nothing here averages or combines
    // scores across dimensions into a single number.
    expect(grouped['eye_fatigue']!.single.score, 2.0);
    expect(grouped['peripheral_vision']!.single.accuracy, greaterThan(0));
    expect(grouped['visual_attention']!.single.accuracy, 1.0);
  });
}
