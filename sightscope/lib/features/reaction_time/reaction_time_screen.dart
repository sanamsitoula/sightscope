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
import 'reaction_time_test_definition.dart';

enum _TrialStage { waiting, armed, tooEarly }

class ReactionTimeScreen extends ConsumerStatefulWidget {
  const ReactionTimeScreen({super.key});

  @override
  ConsumerState<ReactionTimeScreen> createState() => _ReactionTimeScreenState();
}

class _ReactionTimeScreenState extends ConsumerState<ReactionTimeScreen> {
  TestSessionController? _controller;
  _TrialStage _stage = _TrialStage.waiting;
  DateTime? _stimulusShownAt;

  void _start() {
    final repository = TestResultRepository(ref.read(appDatabaseProvider));
    final controller = TestSessionController(
      definition: ReactionTimeTestDefinition(),
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
    _scheduleTrial();
  }

  void _scheduleTrial() {
    final controller = _controller;
    if (controller == null) return;
    final stimulus = controller.state.currentStimulus;
    if (stimulus == null) return;
    setState(() => _stage = _TrialStage.waiting);
    final int delayMs = stimulus.payload['delayMs'] as int;
    Future.delayed(Duration(milliseconds: delayMs), () {
      if (!mounted || _controller != controller || controller.state.currentStimulus != stimulus) {
        return;
      }
      setState(() {
        _stage = _TrialStage.armed;
        _stimulusShownAt = DateTime.now();
      });
    });
  }

  void _onTap() {
    final controller = _controller!;
    if (controller.state.phase != TestSessionPhase.practice &&
        controller.state.phase != TestSessionPhase.mainTest) {
      return;
    }
    final bool falseStart = _stage != _TrialStage.armed;
    final int durationMillis =
        falseStart || _stimulusShownAt == null ? 0 : DateTime.now().difference(_stimulusShownAt!).inMilliseconds;

    controller.recordResponse(
      answer: {'falseStart': falseStart},
      durationMillis: durationMillis,
    );

    if (controller.isQueueExhausted) {
      if (controller.state.phase == TestSessionPhase.practice) {
        controller.beginMainTest();
        setState(() {});
        _scheduleTrial();
      } else {
        controller.score();
        setState(() {});
      }
    } else {
      setState(() {});
      _scheduleTrial();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return Scaffold(
      appBar: AppBar(title: const Text('Reaction Time')),
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
          'Tap anywhere on the screen as soon as the circle appears. Do not tap before it '
          'appears.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        AppSpacing.gapLg,
        FilledButton(onPressed: _start, child: const Text('Start')),
      ],
    );
  }

  Widget _buildPhase(BuildContext context, TestSessionController controller) {
    switch (controller.state.phase) {
      case TestSessionPhase.practice:
      case TestSessionPhase.mainTest:
        return GestureDetector(
          onTap: _onTap,
          behavior: HitTestBehavior.opaque,
          child: SizedBox.expand(
            child: Column(
              children: [
                if (controller.state.isPractice)
                  Text('Practice', style: Theme.of(context).textTheme.labelLarge),
                Expanded(
                  child: Center(
                    child: _stage == _TrialStage.armed
                        ? Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: AppColors.accent,
                              shape: BoxShape.circle,
                            ),
                          )
                        : Text(
                            _stage == _TrialStage.tooEarly ? 'Too early — wait for it' : 'Wait…',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                  ),
                ),
              ],
            ),
          ),
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
              Text('Mean reaction time: ${result.reactionTime.toStringAsFixed(0)} ms'),
              Text('Confidence: ${result.confidence.level.name}'),
              AppSpacing.gapMd,
              const Text(
                'Reaction time varies with device, alertness, fatigue, and practice, so this '
                'is not a clinical or diagnostic measurement. This is an educational '
                'self-assessment, not a medical diagnosis.',
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
