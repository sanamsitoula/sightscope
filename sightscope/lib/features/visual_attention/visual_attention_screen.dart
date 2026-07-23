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
import 'visual_attention_test_definition.dart';

class VisualAttentionScreen extends ConsumerStatefulWidget {
  const VisualAttentionScreen({super.key});

  @override
  ConsumerState<VisualAttentionScreen> createState() => _VisualAttentionScreenState();
}

class _VisualAttentionScreenState extends ConsumerState<VisualAttentionScreen> {
  TestSessionController? _controller;
  DateTime? _trialShownAt;

  void _start() {
    final repository = TestResultRepository(ref.read(appDatabaseProvider));
    final controller = TestSessionController(
      definition: VisualAttentionTestDefinition(),
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
    _trialShownAt = DateTime.now();
    setState(() => _controller = controller);
  }

  void _respond(int tappedIndex) {
    final controller = _controller!;
    final int duration =
        _trialShownAt == null ? 0 : DateTime.now().difference(_trialShownAt!).inMilliseconds;
    controller.recordResponse(answer: {'tappedIndex': tappedIndex}, durationMillis: duration);
    if (controller.isQueueExhausted) {
      if (controller.state.phase == TestSessionPhase.practice) {
        controller.beginMainTest();
      } else {
        controller.score();
      }
    }
    _trialShownAt = DateTime.now();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return Scaffold(
      appBar: AppBar(title: const Text('Visual Attention')),
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
          'Tap the circle that is a different color from the others, as quickly as you can.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const TestPurposeCard(testId: 'visual_attention'),
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
        final int itemCount = stimulus.payload['itemCount'] as int;
        final int targetIndex = stimulus.payload['targetIndex'] as int;
        final List<dynamic> positions = stimulus.payload['positions'] as List<dynamic>;
        final Color targetColor = Color(stimulus.payload['targetColor'] as int);
        final Color distractorColor = Color(stimulus.payload['distractorColor'] as int);
        return Column(
          children: [
            if (controller.state.isPractice)
              Text('Practice', style: Theme.of(context).textTheme.labelLarge),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                return Stack(
                  children: [
                    for (int i = 0; i < itemCount; i++)
                      Positioned(
                        left: (positions[i]['dx'] as double) * constraints.maxWidth - 18,
                        top: (positions[i]['dy'] as double) * constraints.maxHeight - 18,
                        child: GestureDetector(
                          onTap: () => _respond(i),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: i == targetIndex ? targetColor : distractorColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }),
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
                'This is an educational screening measure of visual search performance, not a '
                'diagnostic attention or cognitive assessment.',
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
