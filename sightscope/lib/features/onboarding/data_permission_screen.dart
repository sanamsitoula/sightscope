import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/calibration/calibration_provider.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/gradient_hero_header.dart';
import 'data_collection_list.dart';

/// First-launch data-collection consent step, shown after the disclaimer
/// and before the dashboard. This is a disclosure/consent gate, not an OS
/// permission dialog — SightScope doesn't request camera, microphone, or
/// location access, so there is nothing for the OS to prompt for here.
/// Optional device permissions (notifications, Android usage access) are
/// requested separately and later, only if the user turns them on under
/// Eye Wellness settings.
class DataPermissionScreen extends ConsumerWidget {
  const DataPermissionScreen({super.key, required this.onAllowed});

  final VoidCallback onAllowed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GradientHeroHeader(
              title: 'Your data, on your terms',
              subtitle: 'Here is exactly what SightScope stores, and what it never touches.',
              compact: true,
              showEye: false,
            ),
            Padding(
              padding: AppSpacing.padScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DataCollectionList(),
                  AppSpacing.gapLg,
                  const Text(
                    'You can review this at any time from the app, and features that need an '
                    'extra device permission — like notifications — will ask separately, only '
                    'when you turn them on.',
                  ),
                  AppSpacing.gapLg,
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      key: const Key('data_permission_allow_button'),
                      onPressed: () async {
                        await ref.read(securePrefsProvider).setDataCollectionAccepted(true);
                        onAllowed();
                      },
                      child: const Text('Allow and continue'),
                    ),
                  ),
                  AppSpacing.gapMd,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
