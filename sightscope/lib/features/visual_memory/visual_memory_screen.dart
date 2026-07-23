import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/storage/database_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/models/enums.dart';
import '../../shared/test_engine/domain/test_session_phase.dart';
import '../../shared/test_engine/engine/test_device_context.dart';
import '../../shared/test_engine/engine/test_result_repository.dart';
import '../../shared/test_engine/engine/test_session_controller.dart';
import '../../shared/test_engine/widgets/accessibility_notice.dart';
import '../../shared/widgets/test_purpose_card.dart';
import 'visual_memory_test_definition.dart';

enum _MemoryStage { study, blank, test }

class VisualMemoryScreen extends ConsumerStatefulWidget {
  const VisualMemoryScreen({super.key});

  @override
  ConsumerState<VisualMemoryScreen> createState() => _VisualMemoryScreenState();
}

class _VisualMemoryScreenState extends ConsumerState<VisualMemoryScreen> {
  TestSessionController? _controller;
  _MemoryStage _stage = _MemoryStage.study;

  void _start() {
    final repository = TestResultRepository(ref.read(appDatabaseProvider));
    final controller = TestSessionController(
      definition: VisualMemoryTestDefinition(),
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
    _scheduleStages();
  }

  void _scheduleStages() {
    setState(() => _stage = _MemoryStage.study);
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() => _stage = _MemoryStage.blank);
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (!mounted) return;
        setState(() => _stage = _MemoryStage.test);
      });
    });
  }

  void _respond(String response) {
    final controller = _controller!;
    controller.recordResponse(answer: {'response': response}, durationMillis: 0);
    if (controller.isQueueExhausted) {
      if (controller.state.phase == TestSessionPhase.practice) {
        controller.beginMainTest();
        setState(() {});
        _scheduleStages();
      } else {
        controller.score();
        setState(() {});
      }
    } else {
      setState(() {});
      _scheduleStages();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return Scaffold(
      appBar: AppBar(title: const Text('Visual Memory')),
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
          'Remember the colored squares. After they disappear and reappear, say whether one '
          'changed color.',
          style: AppTypography.body,
        ),
        const TestPurposeCard(testId: 'visual_memory'),
        const AccessibilityNotice(),
        AppSpacing.gapLg,
        FilledButton(onPressed: _start, child: const Text('Start test')),
      ],
    );
  }

  Widget _buildPhase(BuildContext context, TestSessionController controller) {
    switch (controller.state.phase) {
      case TestSessionPhase.practice:
      case TestSessionPhase.mainTest:
        final stimulus = controller.state.currentStimulus;
        if (stimulus == null) return const Center(child: CircularProgressIndicator());
        final int setSize = stimulus.payload['setSize'] as int;
        final List<dynamic> positions = stimulus.payload['positions'] as List<dynamic>;
        final List<dynamic> studyColors = stimulus.payload['studyColors'] as List<dynamic>;
        final int? changeIndex = stimulus.payload['changeIndex'] as int?;
        final int? newColor = stimulus.payload['newColor'] as int?;

        return Column(
          children: [
            if (controller.state.isPractice)
              Text('PRACTICE', style: AppTypography.overline.copyWith(color: AppColors.sage)),
            Expanded(
              child: _stage == _MemoryStage.blank
                  ? const SizedBox.expand()
                  : LayoutBuilder(builder: (context, constraints) {
                      return Stack(
                        children: [
                          for (int i = 0; i < setSize; i++)
                            Positioned(
                              left: (positions[i]['dx'] as double) * constraints.maxWidth - 24,
                              top: (positions[i]['dy'] as double) * constraints.maxHeight - 24,
                              child: Container(
                                width: 48,
                                height: 48,
                                color: Color(
                                  _stage == _MemoryStage.test && i == changeIndex
                                      ? newColor!
                                      : studyColors[i] as int,
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
            ),
            if (_stage == _MemoryStage.test)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton(onPressed: () => _respond('same'), child: const Text('Same')),
                  FilledButton(onPressed: () => _respond('changed'), child: const Text('Changed')),
                ],
              )
            else
              Text(_stage == _MemoryStage.study ? 'Remember…' : ' ',
                  style: Theme.of(context).textTheme.labelLarge),
            AppSpacing.gapMd,
          ],
        );
      case TestSessionPhase.scoring:
      case TestSessionPhase.confidence:
        return const Center(child: CircularProgressIndicator());
      case TestSessionPhase.result:
        final result = controller.state.result!;
        final double approxK = (result.scoring.metrics['approxK'] as num?)?.toDouble() ?? 0;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('YOUR RESULT', style: AppTypography.overline.copyWith(color: AppColors.sage)),
              AppSpacing.gapMd,
              Text('Accuracy: ${(result.accuracy * 100).toStringAsFixed(0)}%'),
              Text('Approximate capacity (K): ${approxK.toStringAsFixed(1)} items'),
              Text('Confidence: ${result.confidence.level.name}'),
              AppSpacing.gapMd,
              const Text(
                'This is an educational self-assessment, not a diagnostic memory or cognitive '
                'test, and the small number of trials means the estimate is approximate.',
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
