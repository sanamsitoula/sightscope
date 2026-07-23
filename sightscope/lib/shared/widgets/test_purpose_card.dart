import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_shapes.dart';
import '../../core/theme/app_spacing.dart';

class TestPurposeInfo {
  const TestPurposeInfo({required this.icon, required this.whatItTests, required this.whyItHelps});
  final IconData icon;
  final String whatItTests;
  final String whyItHelps;
}

/// Centralized "what this tests / why it helps" copy per testId, so every
/// test intro can show it with one line of code instead of duplicating
/// marketing copy across screens.
const Map<String, TestPurposeInfo> kTestPurposeInfo = {
  'visual_acuity': TestPurposeInfo(
    icon: Icons.remove_red_eye_outlined,
    whatItTests: 'How small a shape you can reliably tell apart at your current distance.',
    whyItHelps: 'Sharp distance vision affects reading signs, screens, and faces clearly.',
  ),
  'near_vision': TestPurposeInfo(
    icon: Icons.menu_book_outlined,
    whatItTests: 'The smallest comfortable print size at a normal reading distance.',
    whyItHelps: 'Near-vision changes are common with age and affect reading and close work.',
  ),
  'contrast_sensitivity': TestPurposeInfo(
    icon: Icons.contrast,
    whatItTests: 'How faint a shape can be while you can still make it out.',
    whyItHelps: 'Contrast sensitivity matters for driving at night, fog, and low light.',
  ),
  'color_vision': TestPurposeInfo(
    icon: Icons.palette_outlined,
    whatItTests: 'Whether subtle red-green color differences are easy for you to spot.',
    whyItHelps: 'Color perception affects everyday tasks like reading charts and signals.',
  ),
  'reaction_time': TestPurposeInfo(
    icon: Icons.bolt_outlined,
    whatItTests: 'How quickly you respond to a sudden visual change.',
    whyItHelps: 'Visual-motor speed relates to alertness and everyday reaction demands.',
  ),
  'depth_perception': TestPurposeInfo(
    icon: Icons.layers_outlined,
    whatItTests: 'How well you judge which of two on-screen shapes looks nearer.',
    whyItHelps: 'Depth cues help with judging distance, reaching, and spatial tasks.',
  ),
  'peripheral_vision': TestPurposeInfo(
    icon: Icons.visibility_outlined,
    whatItTests: 'How reliably you notice a brief flash near the edge of your view.',
    whyItHelps: 'Peripheral awareness matters for noticing movement around you.',
  ),
  'visual_attention': TestPurposeInfo(
    icon: Icons.center_focus_strong_outlined,
    whatItTests: 'How quickly you can spot an odd-colored target among distractors.',
    whyItHelps: 'Visual search speed relates to how efficiently you scan a scene.',
  ),
  'visual_memory': TestPurposeInfo(
    icon: Icons.grid_view_outlined,
    whatItTests: 'How many colored items you can briefly hold in mind.',
    whyItHelps: 'Visual working memory supports everyday tasks like remembering layouts.',
  ),
  'motion_perception': TestPurposeInfo(
    icon: Icons.blur_on,
    whatItTests: 'The weakest coherent motion signal you can still detect.',
    whyItHelps: 'Motion sensitivity helps with noticing moving objects and traffic.',
  ),
  'eye_fatigue': TestPurposeInfo(
    icon: Icons.self_improvement_outlined,
    whatItTests: 'How often you have noticed common digital eye-strain symptoms.',
    whyItHelps: 'Tracking symptoms can highlight when a screen-use break would help.',
  ),
};

/// "What this tests / why it helps" card shown on test intro screens.
class TestPurposeCard extends StatelessWidget {
  const TestPurposeCard({super.key, required this.testId});

  final String testId;

  @override
  Widget build(BuildContext context) {
    final TestPurposeInfo? info = kTestPurposeInfo[testId];
    if (info == null) return const SizedBox.shrink();
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.md, bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppShapes.radiusLg),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.brandSeed.withValues(alpha: 0.15),
            child: Icon(info.icon, color: AppColors.brandSeed),
          ),
          AppSpacing.gapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('What this tests', style: Theme.of(context).textTheme.labelLarge),
                Text(info.whatItTests, style: Theme.of(context).textTheme.bodyMedium),
                AppSpacing.gapSm,
                Text('Why it helps', style: Theme.of(context).textTheme.labelLarge),
                Text(info.whyItHelps, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
