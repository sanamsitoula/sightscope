import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../domain/eye_exercise_engine.dart';

/// The guided "One-Minute Reset" eye-relaxation exercise (EyeGuard spec
/// §8/§9). Peaceful, not medical — dark, minimal, no urgency.
class OneMinuteResetScreen extends StatefulWidget {
  const OneMinuteResetScreen({super.key});

  @override
  State<OneMinuteResetScreen> createState() => _OneMinuteResetScreenState();
}

class _OneMinuteResetScreenState extends State<OneMinuteResetScreen> {
  int _stepIndex = 0;
  late int _secondsRemaining = kOneMinuteReset.first.duration.inSeconds;
  Timer? _timer;
  bool _complete = false;

  @override
  void initState() {
    super.initState();
    _startTick();
  }

  void _startTick() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (_secondsRemaining > 1) {
          _secondsRemaining--;
        } else {
          _advance();
        }
      });
    });
  }

  void _advance() {
    if (_stepIndex >= kOneMinuteReset.length - 1) {
      _timer?.cancel();
      _complete = true;
      return;
    }
    _stepIndex++;
    _secondsRemaining = kOneMinuteReset[_stepIndex].duration.inSeconds;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepInk,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.padScreen,
          child: _complete ? _buildComplete(context) : _buildStep(context),
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context) {
    final EyeExerciseStep step = kOneMinuteReset[_stepIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text('End', style: AppTypography.body.copyWith(color: Colors.white70)),
        ),
        const Spacer(),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ONE-MINUTE RESET',
                style: AppTypography.overline.copyWith(color: AppColors.sage),
              ),
              AppSpacing.gapXl,
              Text(
                '$_secondsRemaining',
                style: AppTypography.display.copyWith(color: Colors.white, fontSize: 64),
              ),
              AppSpacing.gapXl,
              Text(
                step.title.toUpperCase(),
                style: AppTypography.sectionTitle.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              AppSpacing.gapSm,
              Text(
                step.instruction,
                style: AppTypography.body.copyWith(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < kOneMinuteReset.length; i++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == _stepIndex ? 18 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: i == _stepIndex ? AppColors.sage : Colors.white24,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
          ],
        ),
        AppSpacing.gapLg,
      ],
    );
  }

  Widget _buildComplete(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_outline, color: AppColors.sage, size: 40),
          AppSpacing.gapLg,
          Text(
            'RESET COMPLETE',
            style: AppTypography.overline.copyWith(color: AppColors.sage),
          ),
          AppSpacing.gapMd,
          Text(
            'You gave your eyes a short break.\nNice work.',
            textAlign: TextAlign.center,
            style: AppTypography.sectionTitle.copyWith(color: Colors.white),
          ),
          AppSpacing.gapXl,
          SizedBox(
            width: 200,
            child: FilledButton(onPressed: () => context.pop(), child: const Text('Done')),
          ),
        ],
      ),
    );
  }
}
