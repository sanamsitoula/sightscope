import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/calibration/calibration_provider.dart';
import '../../core/theme/app_spacing.dart';

/// First-launch disclaimer gate (Task.md §15 / spec.md Gate 1: "Disclaimer
/// gate on first launch"). The app is not usable until this is accepted.
class DisclaimerScreen extends ConsumerWidget {
  const DisclaimerScreen({super.key, required this.onAccepted});

  final VoidCallback onAccepted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Before you begin')),
      body: SingleChildScrollView(
        padding: AppSpacing.padScreen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SightScope', style: Theme.of(context).textTheme.headlineLarge),
            AppSpacing.gapMd,
            Text(
              'SightScope is an educational self-assessment tool. It screens aspects of your '
              'vision using science-inspired tests, but it is not a medical device and does '
              'not diagnose any condition.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            AppSpacing.gapMd,
            const Text(
              'Your results are affected by your device, screen, lighting, and viewing '
              'distance, and should not be interpreted as a clinical measurement. If you have '
              'concerns about your vision, please consult a qualified eye-care professional.',
            ),
            AppSpacing.gapMd,
            const Text('All of your results stay private on this device.'),
            AppSpacing.gapLg,
            FilledButton(
              key: const Key('disclaimer_accept_button'),
              onPressed: () async {
                await ref.read(securePrefsProvider).setDisclaimerAccepted(true);
                onAccepted();
              },
              child: const Text('I understand, continue'),
            ),
          ],
        ),
      ),
    );
  }
}
