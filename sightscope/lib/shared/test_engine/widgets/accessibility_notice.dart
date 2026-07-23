import 'package:flutter/material.dart';

import '../../../core/accessibility/accessibility.dart';
import '../../../core/theme/app_spacing.dart';

/// Shown on test intro screens when the platform has high-contrast enabled
/// (Task.md §16/§24 accessibility pass): warns that visual-comparison
/// results won't be comparable to a standard-contrast session, without
/// blocking the user from proceeding.
class AccessibilityNotice extends StatelessWidget {
  const AccessibilityNotice({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Accessibility.highContrast(context)) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Semantics(
        liveRegion: true,
        child: Text(
          'High-contrast mode is on. It changes how these visual stimuli appear, so this '
          "result won't be comparable to a standard-contrast session.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
