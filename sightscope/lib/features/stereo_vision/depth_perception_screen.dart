import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/storage/database_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/models/enums.dart';
import '../../shared/test_engine/domain/test_session_phase.dart';
import '../../shared/test_engine/engine/test_device_context.dart';
import '../../shared/test_engine/engine/test_result_repository.dart';
import '../../shared/test_engine/engine/test_session_controller.dart';
import '../../shared/test_engine/widgets/accessibility_notice.dart';
import 'depth_perception_test_definition.dart';

class DepthPerceptionScreen extends ConsumerStatefulWidget {
  const DepthPerceptionScreen({super.key});

  @override
  ConsumerState<DepthPerceptionScreen> createState() => _DepthPerceptionScreenState();
}

class _DepthPerceptionScreenState extends ConsumerState<DepthPerceptionScreen> {
  TestSessionController? _controller;

  void _start() {
    final repository = TestResultRepository(ref.read(appDatabaseProvider));
    final controller = TestSessionController(
      definition: DepthPerceptionTestDefinition(),
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

  void _respond(String choice) {
    final controller = _controller!;
    controller.recordResponse(answer: {'choice': choice}, durationMillis: 0);
    if (controller.isQueueExhausted) {
      if (controller.state.phase == TestSessionPhase.practice) {
        controller.beginMainTest();
      } else {
        controller.score();
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return Scaffold(
      appBar: AppBar(title: const Text('Depth Perception')),
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
          'Tap whichever shape looks nearer to you. This screens depth cues from a flat '
          'screen, not true binocular stereo depth.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
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
        final double strength = (stimulus.payload['strength'] as num).toDouble();
        final bool nearIsLeft = stimulus.payload['nearIsLeft'] as bool;
        const double nearSize = 100;
        final double farSize = 100 - 70 * strength;
        return Column(
          children: [
            if (controller.state.isPractice)
              Text('Practice', style: Theme.of(context).textTheme.labelLarge),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => _respond('left'),
                    child: _DepthCircle(size: nearIsLeft ? nearSize : farSize),
                  ),
                  GestureDetector(
                    onTap: () => _respond('right'),
                    child: _DepthCircle(size: nearIsLeft ? farSize : nearSize),
                  ),
                ],
              ),
            ),
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
                'This screens depth-cue judgment from on-screen visual cues, not true '
                'binocular stereo depth, which this screen cannot measure directly. This is '
                'an educational self-assessment, not a diagnosis.',
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

class _DepthCircle extends StatelessWidget {
  const _DepthCircle({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
    );
  }
}
