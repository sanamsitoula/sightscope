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
import '../../shared/test_engine/widgets/orientation_response_pad.dart';
import '../../shared/widgets/test_purpose_card.dart';
import 'peripheral_vision_test_definition.dart';

const Map<int, String> _kOrientationToQuadrant = {0: 'right', 90: 'up', 180: 'left', 270: 'down'};

enum _FlashStage { waiting, flashing, blankWindow }

class PeripheralVisionScreen extends ConsumerStatefulWidget {
  const PeripheralVisionScreen({super.key});

  @override
  ConsumerState<PeripheralVisionScreen> createState() => _PeripheralVisionScreenState();
}

class _PeripheralVisionScreenState extends ConsumerState<PeripheralVisionScreen> {
  TestSessionController? _controller;
  _FlashStage _stage = _FlashStage.waiting;
  DateTime? _flashShownAt;
  bool _answeredThisTrial = false;

  void _start() {
    final repository = TestResultRepository(ref.read(appDatabaseProvider));
    final controller = TestSessionController(
      definition: PeripheralVisionTestDefinition(),
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
    _answeredThisTrial = false;
    setState(() => _stage = _FlashStage.waiting);
    final int preDelay = stimulus.payload['preDelayMs'] as int;
    final int flashMs = stimulus.payload['flashDurationMs'] as int;
    final int windowMs = stimulus.payload['responseWindowMs'] as int;

    Future.delayed(Duration(milliseconds: preDelay), () {
      if (!mounted || _controller != controller || controller.state.currentStimulus != stimulus) {
        return;
      }
      setState(() {
        _stage = _FlashStage.flashing;
        _flashShownAt = DateTime.now();
      });
      Future.delayed(Duration(milliseconds: flashMs), () {
        if (!mounted || _controller != controller || controller.state.currentStimulus != stimulus) {
          return;
        }
        setState(() => _stage = _FlashStage.blankWindow);
      });
      Future.delayed(Duration(milliseconds: windowMs), () {
        if (!mounted ||
            _controller != controller ||
            controller.state.currentStimulus != stimulus ||
            _answeredThisTrial) {
          return;
        }
        _submit(controller, stimulus, tapped: false, quadrant: null);
      });
    });
  }

  void _submit(
    TestSessionController controller,
    dynamic stimulus, {
    required bool tapped,
    required String? quadrant,
  }) {
    if (_answeredThisTrial) return;
    _answeredThisTrial = true;
    final int durationMillis =
        tapped && _flashShownAt != null ? DateTime.now().difference(_flashShownAt!).inMilliseconds : 0;
    controller.recordResponse(
      answer: {'quadrant': quadrant, 'tapped': tapped},
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
      appBar: AppBar(title: const Text('Peripheral Awareness')),
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
          'Keep looking at the center dot. When you notice a brief flash near an edge, tap the '
          'matching arrow. Some trials have no flash — leave those alone.',
          style: AppTypography.body,
        ),
        const TestPurposeCard(testId: 'peripheral_vision'),
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
        final String? quadrant = stimulus.payload['quadrant'] as String?;
        return Column(
          children: [
            if (controller.state.isPractice)
              Text('PRACTICE', style: AppTypography.overline.copyWith(color: AppColors.sage)),
            Expanded(
              child: Stack(
                children: [
                  const Center(
                    child: Icon(Icons.add, size: 32, color: AppColors.stimulusInk),
                  ),
                  if (_stage == _FlashStage.flashing && quadrant != null)
                    _PeripheralDot(quadrant: quadrant),
                ],
              ),
            ),
            OrientationResponsePad(
              enabled: true,
              onSelected: (orientation) => _submit(
                controller,
                stimulus,
                tapped: true,
                quadrant: _kOrientationToQuadrant[orientation],
              ),
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
              Text('YOUR RESULT', style: AppTypography.overline.copyWith(color: AppColors.sage)),
              AppSpacing.gapMd,
              Text('Accuracy: ${(result.accuracy * 100).toStringAsFixed(0)}%'),
              Text('Confidence: ${result.confidence.level.name}'),
              AppSpacing.gapMd,
              const Text(
                'This app cannot verify that you kept looking at the center dot, so this is an '
                'educational screening task, not a clinical visual-field test.',
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

class _PeripheralDot extends StatelessWidget {
  const _PeripheralDot({required this.quadrant});

  final String quadrant;

  @override
  Widget build(BuildContext context) {
    const double margin = 24;
    final Alignment alignment = switch (quadrant) {
      'right' => Alignment.centerRight,
      'up' => Alignment.topCenter,
      'left' => Alignment.centerLeft,
      'down' => Alignment.bottomCenter,
      _ => Alignment.center,
    };
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(margin),
        child: Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(color: AppColors.sage, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
