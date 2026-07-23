import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_spacing.dart';

/// Phase-0 placeholder. Replaced by the real home dashboard in Phase 1.
class HomePlaceholderScreen extends StatelessWidget {
  const HomePlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SightScope')),
      body: Padding(
        padding: AppSpacing.padScreen,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Foundation build', style: Theme.of(context).textTheme.titleLarge),
              AppSpacing.gapMd,
              FilledButton(
                onPressed: () => context.push('/dummy-test'),
                child: const Text('Run engine demo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
