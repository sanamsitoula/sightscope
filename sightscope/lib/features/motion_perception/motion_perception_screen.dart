import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/accessibility/accessibility.dart';
import '../../core/storage/database_provider.dart';
import '../../shared/test_engine/widgets/accessibility_notice.dart';
import '../../shared/widgets/test_purpose_card.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/models/enums.dart';
import '../../shared/test_engine/domain/test_session_phase.dart';
import '../../shared/test_engine/engine/test_device_context.dart';
import '../../shared/test_engine/engine/test_result_repository.dart';
import '../../shared/test_engine/engine/test_session_controller.dart';
import 'motion_perception_test_definition.dart';
import 'rdk_painter.dart';

class MotionPerceptionScreen extends ConsumerStatefulWidget {
  const MotionPerceptionScreen({super.key});

  @override
  ConsumerState<MotionPerceptionScreen> createState() => _MotionPerceptionScreenState();
}

class _MotionPerceptionScreenState extends ConsumerState<MotionPerceptionScreen>
    with SingleTickerProviderStateMixin {
  TestSessionController? _controller;
  late final AnimationController _anim =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
  bool _playing = false;

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void _start() {
    final repository = TestResultRepository(ref.read(appDatabaseProvider));
    final controller = TestSessionController(
      definition: MotionPerceptionTestDefinition(),
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
    _playTrial();
  }

  void _playTrial() {
    setState(() => _playing = true);
    _anim
      ..reset()
      ..forward().whenComplete(() {
        if (mounted) setState(() => _playing = false);
      });
  }

  void _respond(String direction) {
    final controller = _controller!;
    controller.recordResponse(answer: {'direction': direction}, durationMillis: 0);
    if (controller.isQueueExhausted) {
      if (controller.state.phase == TestSessionPhase.practice) {
        controller.beginMainTest();
        setState(() {});
        _playTrial();
      } else {
        controller.score();
        setState(() {});
      }
    } else {
      setState(() {});
      _playTrial();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return Scaffold(
      appBar: AppBar(title: const Text('Motion Perception')),
      body: Padding(
        padding: AppSpacing.padScreen,
        child: controller == null ? _buildIntro(context) : _buildPhase(context, controller),
      ),
    );
  }

  Widget _buildIntro(BuildContext context) {
    final bool reduceMotion = Accessibility.reduceMotion(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Watch the moving dots and indicate whether they drift mostly left or mostly right.',
          style: AppTypography.body,
        ),
        if (reduceMotion) ...[
          AppSpacing.gapMd,
          const Text(
            'Your device has reduced motion enabled. This test inherently involves motion and '
            'cannot be shown statically — skip it if moving dot patterns are uncomfortable for '
            'you.',
          ),
        ],
        const TestPurposeCard(testId: 'motion_perception'),
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
        final double coherence = (stimulus.payload['coherence'] as num).toDouble();
        final String direction = stimulus.payload['direction'] as String;
        final int seed = stimulus.payload['seed'] as int;
        return Column(
          children: [
            if (controller.state.isPractice)
              Text('PRACTICE', style: AppTypography.overline.copyWith(color: AppColors.sage)),
            Expanded(
              child: AnimatedBuilder(
                animation: _anim,
                builder: (context, _) => CustomPaint(
                  size: Size.infinite,
                  painter: RdkPainter(
                    t: _anim.value,
                    coherence: coherence,
                    direction: direction,
                    seed: seed,
                  ),
                ),
              ),
            ),
            AppSpacing.gapMd,
            if (!_playing)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton.icon(
                    onPressed: () => _respond('left'),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Left'),
                  ),
                  FilledButton.icon(
                    onPressed: () => _respond('right'),
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Right'),
                  ),
                ],
              )
            else
              const Text('Watch…'),
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
              Text('YOUR RESULT', style: AppTypography.overline.copyWith(color: AppColors.sage)),
              AppSpacing.gapMd,
              Text('Coherence threshold: ${(result.score * 100).toStringAsFixed(0)}%'),
              Text('Confidence: ${result.confidence.level.name}'),
              AppSpacing.gapMd,
              const Text(
                'This is an educational self-assessment, not a diagnostic measurement of motion '
                'perception or visual processing.',
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
