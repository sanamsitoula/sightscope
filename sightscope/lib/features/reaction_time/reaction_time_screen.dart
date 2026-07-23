import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/storage/database_provider.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/models/enums.dart';
import '../../shared/test_engine/domain/test_session_phase.dart';
import '../../shared/test_engine/engine/test_device_context.dart';
import '../../shared/test_engine/engine/test_result_repository.dart';
import '../../shared/test_engine/engine/test_session_controller.dart';
import '../../shared/widgets/focus_target_painter.dart';
import '../../shared/widgets/gradient_hero_header.dart';
import '../../shared/widgets/how_to_carousel.dart';
import '../../shared/widgets/test_purpose_card.dart';
import 'reaction_time_test_definition.dart';

enum _TrialStage { waiting, armed, tooEarly }

const List<HowToStep> _kReactionHowTo = [
  HowToStep(icon: Icons.remove_red_eye_outlined, label: 'Watch the center of the screen'),
  HowToStep(icon: Icons.adjust, label: 'A focus target will appear without warning'),
  HowToStep(icon: Icons.touch_app_outlined, label: 'Tap anywhere as fast as you can'),
];

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
      appBar: controller == null ? null : AppBar(title: const Text('Reaction Time')),
      body: controller == null ? _buildIntro(context) : _buildPhase(context, controller),
    );
  }

  Widget _buildIntro(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GradientHeroHeader(
            title: 'Reaction Time',
            subtitle: 'Tap the moment you see the focus target appear.',
            compact: true,
          ),
          Padding(
            padding: AppSpacing.padScreen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TestPurposeCard(testId: 'reaction_time'),
                AppSpacing.gapMd,
                const HowToCarousel(steps: _kReactionHowTo),
                AppSpacing.gapLg,
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(onPressed: _start, child: const Text('Start test')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhase(BuildContext context, TestSessionController controller) {
    switch (controller.state.phase) {
      case TestSessionPhase.practice:
      case TestSessionPhase.mainTest:
        return GestureDetector(
          onTap: _onTap,
          behavior: HitTestBehavior.opaque,
          child: ColoredBox(
            // The brand disappears during measurement — a flat canvas, no
            // gradient (docs/brand.md §18).
            color: Theme.of(context).colorScheme.surface,
            child: SizedBox.expand(
              child: SafeArea(
                child: Column(
                  children: [
                    if (controller.state.isPractice)
                      Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.sm),
                        child: Text(
                          'PRACTICE',
                          style: AppTypography.overline.copyWith(color: AppColors.sage),
                        ),
                      ),
                    Expanded(
                      child: Center(
                        child: _stage == _TrialStage.armed
                            ? _PulsingFocusTarget()
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.remove_red_eye_outlined,
                                    size: 40,
                                    color: Theme.of(context).colorScheme.outline,
                                  ),
                                  AppSpacing.gapSm,
                                  Text(
                                    _stage == _TrialStage.tooEarly
                                        ? 'Too early — wait for it'
                                        : 'Wait…',
                                    style: AppTypography.sectionTitle,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      case TestSessionPhase.scoring:
      case TestSessionPhase.confidence:
        return const Center(child: CircularProgressIndicator());
      case TestSessionPhase.result:
        final result = controller.state.result!;
        return SingleChildScrollView(
          padding: AppSpacing.padResult,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('YOUR RESULT', style: AppTypography.overline.copyWith(color: AppColors.sage)),
              AppSpacing.gapSm,
              Text(result.reactionTime.toStringAsFixed(0), style: AppTypography.metric),
              AppSpacing.gapXs,
              const Text('ms mean reaction time', style: AppTypography.cardTitle),
              AppSpacing.gapXl,
              const Divider(height: 1),
              AppSpacing.gapLg,
              Text('CONFIDENCE', style: AppTypography.overline.copyWith(color: AppColors.sage)),
              AppSpacing.gapXs,
              Text(result.confidence.level.name, style: AppTypography.cardTitle),
              AppSpacing.gapLg,
              const Divider(height: 1),
              AppSpacing.gapLg,
              Text('WHAT THIS MEANS', style: AppTypography.overline.copyWith(color: AppColors.sage)),
              AppSpacing.gapXs,
              const Text(
                'Reaction time varies with device, alertness, fatigue, and practice, so this '
                'is not a clinical or diagnostic measurement. This is an educational '
                'self-assessment, not a medical diagnosis.',
                style: AppTypography.body,
              ),
              AppSpacing.gapXl,
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    controller.acknowledgeLimitations();
                    controller.chooseNextStep();
                    setState(() {});
                  },
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        );
      case TestSessionPhase.limitations:
      case TestSessionPhase.nextStep:
        return Center(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: AppSpacing.padScreen,
              child: FilledButton(
                onPressed: () async {
                  await controller.persist();
                  controller.complete();
                  if (context.mounted) context.pop();
                },
                child: const Text('Save and finish'),
              ),
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

/// The reaction-time stimulus: the brand's "Focus Target" mark
/// (docs/brand.md §11/§17), gently pulsing to cue the response — flat
/// colors only, no glow.
class _PulsingFocusTarget extends StatefulWidget {
  @override
  State<_PulsingFocusTarget> createState() => _PulsingFocusTargetState();
}

class _PulsingFocusTargetState extends State<_PulsingFocusTarget> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 700))..repeat(reverse: true);

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) {
        final double scale = 1.0 + _pulse.value * 0.06;
        return Transform.scale(scale: scale, child: child);
      },
      child: const FocusTarget(size: 110),
    );
  }
}
