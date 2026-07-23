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
import 'eye_fatigue_test_definition.dart';

const List<String> _kRatingLabels = ['Never', 'Rarely', 'Sometimes', 'Often', 'Very often'];

class EyeFatigueScreen extends ConsumerStatefulWidget {
  const EyeFatigueScreen({super.key});

  @override
  ConsumerState<EyeFatigueScreen> createState() => _EyeFatigueScreenState();
}

class _EyeFatigueScreenState extends ConsumerState<EyeFatigueScreen> {
  TestSessionController? _controller;

  void _start() {
    final repository = TestResultRepository(ref.read(appDatabaseProvider));
    final controller = TestSessionController(
      definition: const EyeFatigueTestDefinition(),
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
    controller.beginMainTest();
    setState(() => _controller = controller);
  }

  void _respond(int rating) {
    final controller = _controller!;
    controller.recordResponse(answer: {'rating': rating}, durationMillis: 0);
    if (controller.isQueueExhausted) controller.score();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return Scaffold(
      appBar: AppBar(title: const Text('Eye Fatigue Questionnaire')),
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
          'A few quick questions about recent eye comfort during screen use. There are no '
          'right or wrong answers.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const TestPurposeCard(testId: 'eye_fatigue'),
        const AccessibilityNotice(),
        AppSpacing.gapLg,
        FilledButton(onPressed: _start, child: const Text('Start')),
      ],
    );
  }

  Widget _buildPhase(BuildContext context, TestSessionController controller) {
    switch (controller.state.phase) {
      case TestSessionPhase.mainTest:
        final stimulus = controller.state.currentStimulus;
        if (stimulus == null) return const Center(child: CircularProgressIndicator());
        final String question = stimulus.payload['question'] as String;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question, style: Theme.of(context).textTheme.titleLarge),
            AppSpacing.gapLg,
            for (int i = 0; i < _kRatingLabels.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: OutlinedButton(
                  onPressed: () => _respond(i),
                  child: Align(alignment: Alignment.centerLeft, child: Text(_kRatingLabels[i])),
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
              Text('Average symptom score: ${result.score.toStringAsFixed(1)} / 4'),
              AppSpacing.gapMd,
              const Text(
                'This is a self-report screening questionnaire, not a diagnosis of digital '
                'eye strain, dry eye disease, or any other condition. If symptoms are frequent '
                'or bothersome, consider discussing them with a qualified eye-care professional.',
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
