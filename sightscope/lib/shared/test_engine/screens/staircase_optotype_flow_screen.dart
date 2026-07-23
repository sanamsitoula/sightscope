import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/calibration/calibration_provider.dart';
import '../../../core/storage/database_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../models/enums.dart';
import '../domain/test_definition.dart';
import '../domain/test_result.dart';
import '../domain/test_session_phase.dart';
import '../engine/test_device_context.dart';
import '../engine/test_result_repository.dart';
import '../engine/test_session_controller.dart';
import '../widgets/accessibility_notice.dart';
import '../widgets/optotype_painter.dart';
import '../widgets/orientation_response_pad.dart';

/// Shared flow for every adaptive-staircase optotype test (visual acuity,
/// near vision, contrast sensitivity — Task.md §11: "every test must use
/// the shared test engine"). Handles the full lifecycle: introduction,
/// instructions, calibration check, practice, main test, scoring,
/// confidence, result + limitations, next step, persistence.
class StaircaseOptotypeFlowScreen extends ConsumerStatefulWidget {
  const StaircaseOptotypeFlowScreen({
    super.key,
    required this.definitionBuilder,
    required this.introText,
    required this.limitationsText,
  });

  /// Builds a fresh [TestDefinition] given the calibrated viewing distance
  /// and PPI. Called once per session start.
  final TestDefinition Function({required double viewingDistanceMm, required double ppi})
      definitionBuilder;
  final String introText;
  final String limitationsText;

  @override
  ConsumerState<StaircaseOptotypeFlowScreen> createState() => _StaircaseOptotypeFlowScreenState();
}

class _StaircaseOptotypeFlowScreenState extends ConsumerState<StaircaseOptotypeFlowScreen> {
  TestSessionController? _controller;
  int _feedbackKey = 0;
  bool? _lastCorrect;

  void _startSession(double viewingDistanceMm, double ppi) {
    final repository = TestResultRepository(ref.read(appDatabaseProvider));
    final definition = widget.definitionBuilder(viewingDistanceMm: viewingDistanceMm, ppi: ppi);
    final controller = TestSessionController(
      definition: definition,
      deviceContext: TestDeviceContext(
        deviceModel: 'unknown',
        screenSize: 'unknown',
        screenDensity: ppi,
        viewingDistanceMm: viewingDistanceMm,
        eyeTested: Eye.both,
        correctionUsed: CorrectionUsed.unknown,
      ),
      repository: repository,
    );
    controller.start();
    controller.acknowledgeInstructions();
    setState(() => _controller = controller);
  }

  void _respond(int orientation) {
    final controller = _controller!;
    final response = controller.recordResponse(
      answer: {'orientation': orientation},
      durationMillis: 0,
    );
    setState(() {
      _lastCorrect = response.correct;
      _feedbackKey++;
    });
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
    final calibrationAsync = ref.watch(calibrationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Test')),
      body: Padding(
        padding: AppSpacing.padScreen,
        child: calibrationAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => Center(child: Text('Calibration error: $e')),
          data: (calibration) {
            final controller = _controller;
            if (controller == null) {
              return _IntroView(
                introText: widget.introText,
                calibrated: calibration != null,
                onStart: () => _startSession(
                  calibration?.viewingDistanceMm ?? 400,
                  calibration?.ppi ?? 400,
                ),
              );
            }
            return _buildForPhase(controller);
          },
        ),
      ),
    );
  }

  Widget _buildForPhase(TestSessionController controller) {
    switch (controller.state.phase) {
      case TestSessionPhase.introduction:
        return const SizedBox.shrink();
      case TestSessionPhase.instructions:
        return _InstructionsView(onContinue: () {
          controller.confirmCalibration();
          setState(() {});
        });
      case TestSessionPhase.calibrationCheck:
        return _CalibrationCheckView(onContinue: () {
          controller.beginPractice();
          setState(() {});
        });
      case TestSessionPhase.practice:
      case TestSessionPhase.mainTest:
        return _TrialView(
          controller: controller,
          lastCorrect: _lastCorrect,
          feedbackKey: _feedbackKey,
          onRespond: _respond,
        );
      case TestSessionPhase.scoring:
      case TestSessionPhase.confidence:
        return const Center(child: CircularProgressIndicator());
      case TestSessionPhase.result:
        return _ResultView(
          result: controller.state.result!,
          limitationsText: widget.limitationsText,
          onContinue: () {
            controller.acknowledgeLimitations();
            controller.chooseNextStep();
            setState(() {});
          },
        );
      case TestSessionPhase.limitations:
      case TestSessionPhase.nextStep:
        return _FinishView(onFinish: () async {
          await controller.persist();
          controller.complete();
          if (mounted) context.pop();
        });
      case TestSessionPhase.notStarted:
      case TestSessionPhase.completed:
      case TestSessionPhase.cancelled:
        return const SizedBox.shrink();
    }
  }
}

class _IntroView extends StatelessWidget {
  const _IntroView({required this.introText, required this.calibrated, required this.onStart});

  final String introText;
  final bool calibrated;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(introText, style: Theme.of(context).textTheme.bodyLarge),
        const AccessibilityNotice(),
        AppSpacing.gapMd,
        if (!calibrated)
          Text(
            'Using an approximate default calibration. For a more accurate result, '
            'calibrate your screen from Settings first.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        AppSpacing.gapLg,
        FilledButton(onPressed: onStart, child: const Text('Start')),
      ],
    );
  }
}

class _InstructionsView extends StatelessWidget {
  const _InstructionsView({required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'A shape will appear. Use the arrow that matches its open side or gap. '
          'Answer as accurately as you can — there is no time limit.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        AppSpacing.gapLg,
        FilledButton(onPressed: onContinue, child: const Text('Continue')),
      ],
    );
  }
}

class _CalibrationCheckView extends StatelessWidget {
  const _CalibrationCheckView({required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hold your device at the recommended distance, in steady, even lighting, '
          'before continuing.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        AppSpacing.gapLg,
        FilledButton(onPressed: onContinue, child: const Text("I'm ready")),
      ],
    );
  }
}

class _TrialView extends StatelessWidget {
  const _TrialView({
    required this.controller,
    required this.lastCorrect,
    required this.feedbackKey,
    required this.onRespond,
  });

  final TestSessionController controller;
  final bool? lastCorrect;
  final int feedbackKey;
  final ValueChanged<int> onRespond;

  @override
  Widget build(BuildContext context) {
    final stimulus = controller.state.currentStimulus;
    final bool isPractice = controller.state.isPractice;
    if (stimulus == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final String shape = stimulus.payload['shape'] as String;
    final int orientation = stimulus.payload['orientation'] as int;
    final double heightPx = (stimulus.payload['heightPx'] as num).toDouble();
    final double strokePx = (stimulus.payload['strokePx'] as num).toDouble();
    final double contrast = (stimulus.payload['contrast'] as num?)?.toDouble() ?? 1.0;
    final Color ink = Color.lerp(AppColors.stimulusPaper, AppColors.stimulusInk, contrast)!;

    return Column(
      children: [
        if (isPractice) Text('Practice', style: Theme.of(context).textTheme.labelLarge),
        Expanded(
          child: Center(
            child: OptotypeView(
              shape: shape == 'E' ? OptotypeShape.tumblingE : OptotypeShape.landoltC,
              heightPx: heightPx.clamp(24, 320),
              strokePx: strokePx.clamp(4, 100),
              orientationDeg: orientation,
              ink: ink,
              paper: AppColors.stimulusPaper,
            ),
          ),
        ),
        if (lastCorrect != null)
          Padding(
            key: ValueKey(feedbackKey),
            padding: const EdgeInsets.only(bottom: 8),
            child: Icon(
              lastCorrect! ? Icons.check_circle : Icons.cancel,
              color: lastCorrect! ? AppColors.okGreen : AppColors.warnAmber,
            ),
          ),
        OrientationResponsePad(onSelected: onRespond),
        AppSpacing.gapMd,
      ],
    );
  }
}

class _ResultView extends StatelessWidget {
  const _ResultView({required this.result, required this.limitationsText, required this.onContinue});

  final TestResult result;
  final String limitationsText;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your result', style: Theme.of(context).textTheme.headlineMedium),
          AppSpacing.gapMd,
          Text('Score: ${result.score.toStringAsFixed(2)}', style: AppTypography.metricValue),
          Text('Confidence: ${result.confidence.level.name}'),
          AppSpacing.gapMd,
          Text(limitationsText, style: Theme.of(context).textTheme.bodyMedium),
          AppSpacing.gapMd,
          const Text(
            'This screening result may be worth discussing with a qualified eye-care '
            'professional. This is an educational self-assessment, not a medical diagnosis.',
          ),
          AppSpacing.gapLg,
          FilledButton(onPressed: onContinue, child: const Text('Continue')),
        ],
      ),
    );
  }
}

class _FinishView extends StatelessWidget {
  const _FinishView({required this.onFinish});

  final Future<void> Function() onFinish;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton(onPressed: onFinish, child: const Text('Save and finish')),
    );
  }
}
