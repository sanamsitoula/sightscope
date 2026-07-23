import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/storage/database_provider.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/models/enums.dart';
import '../../shared/test_engine/domain/test_session_phase.dart';
import '../../shared/test_engine/engine/test_device_context.dart';
import '../../shared/test_engine/engine/test_result_repository.dart';
import '../../shared/test_engine/engine/test_session_controller.dart';
import '../../shared/test_engine/widgets/accessibility_notice.dart';
import '../../shared/widgets/test_purpose_card.dart';
import 'color_plate_painter.dart';
import 'color_vision_test_definition.dart';

class ColorVisionScreen extends ConsumerStatefulWidget {
  const ColorVisionScreen({super.key});

  @override
  ConsumerState<ColorVisionScreen> createState() => _ColorVisionScreenState();
}

class _ColorVisionScreenState extends ConsumerState<ColorVisionScreen> {
  TestSessionController? _controller;

  void _start() {
    final repository = TestResultRepository(ref.read(appDatabaseProvider));
    final controller = TestSessionController(
      definition: const ColorVisionTestDefinition(),
      deviceContext: const TestDeviceContext(
        deviceModel: 'unknown',
        screenSize: 'unknown',
        screenDensity: 0,
        eyeTested: Eye.both,
        correctionUsed: CorrectionUsed.unknown,
      ),
      repository: repository,
    );
    controller.start();
    controller.acknowledgeInstructions();
    controller.confirmCalibration();
    controller.beginPractice();
    setState(() => _controller = controller);
  }

  void _respond(String shape) {
    final controller = _controller!;
    controller.recordResponse(answer: {'shape': shape}, durationMillis: 0);
    if (controller.isQueueExhausted) {
      if (controller.state.phase == TestSessionPhase.practice) {
        controller.beginMainTest();
      } else if (controller.state.phase == TestSessionPhase.mainTest) {
        controller.score();
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return Scaffold(
      appBar: AppBar(title: const Text('Color Perception')),
      body: Padding(
        padding: AppSpacing.padScreen,
        child: controller == null ? _buildIntro(context) : _buildPhase(context, controller),
      ),
    );
  }

  Widget _buildIntro(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Identify the shape hidden in each pattern of colored dots. Choose "None visible" '
          'if you cannot see a shape.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const TestPurposeCard(testId: 'color_vision'),
        const AccessibilityNotice(),
        AppSpacing.gapLg,
        FilledButton(onPressed: _start, child: const Text('Start')),
      ],
    );
  }

  Widget _buildPhase(BuildContext context, TestSessionController controller) {
    switch (controller.state.phase) {
      case TestSessionPhase.practice:
      case TestSessionPhase.mainTest:
        final stimulus = controller.state.currentStimulus;
        if (stimulus == null) return const Center(child: CircularProgressIndicator());
        final String shapeName = stimulus.payload['shape'] as String;
        final double colorDistance = (stimulus.payload['colorDistance'] as num).toDouble();
        final int seed = stimulus.payload['seed'] as int;
        final ColorPlateShape shape = ColorPlateShape.values.firstWhere(
          (s) => s.name == shapeName,
          orElse: () => ColorPlateShape.none,
        );
        return Column(
          children: [
            if (controller.state.isPractice)
              Text('Practice', style: Theme.of(context).textTheme.labelLarge),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 260,
                  height: 260,
                  child: CustomPaint(
                    painter: ColorPlatePainter(seed: seed, shape: shape, colorDistance: colorDistance),
                  ),
                ),
              ),
            ),
            Wrap(
              spacing: 8,
              children: [
                for (final s in ['circle', 'triangle', 'square', 'none'])
                  FilledButton.tonal(
                    onPressed: () => _respond(s),
                    child: Text(s == 'none' ? 'None visible' : s),
                  ),
              ],
            ),
            AppSpacing.gapMd,
          ],
        );
      case TestSessionPhase.scoring:
      case TestSessionPhase.confidence:
        return const Center(child: CircularProgressIndicator());
      case TestSessionPhase.result:
        final result = controller.state.result!;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your result', style: Theme.of(context).textTheme.headlineMedium),
              AppSpacing.gapMd,
              Text('Accuracy: ${(result.accuracy * 100).toStringAsFixed(0)}%'),
              Text('Confidence: ${result.confidence.level.name}'),
              AppSpacing.gapMd,
              const Text(
                'This is a screening flag, not a diagnostic color-vision test, and cannot '
                'determine a specific type of color-vision difference. Display color rendering '
                'varies by device. This is an educational self-assessment, not a medical diagnosis.',
              ),
              AppSpacing.gapLg,
              FilledButton(
                onPressed: () {
                  controller.acknowledgeLimitations();
                  controller.chooseNextStep();
                  setState(() {});
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        );
      case TestSessionPhase.limitations:
      case TestSessionPhase.nextStep:
        return Center(
          child: FilledButton(
            onPressed: () async {
              await controller.persist();
              controller.complete();
              if (context.mounted) context.pop();
            },
            child: const Text('Save and finish'),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
