import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_shapes.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/gradient_hero_header.dart';

class _TestEntry {
  const _TestEntry(this.title, this.subtitle, this.route, this.icon, this.color);
  final String title;
  final String subtitle;
  final String route;
  final IconData icon;
  final Color color;
}

const List<_TestEntry> _kPhase1Tests = [
  _TestEntry('Visual Acuity', 'How sharply you see fine detail', '/tests/visual-acuity', Icons.remove_red_eye_outlined, Color(0xFF0E7C86)),
  _TestEntry('Near Vision & Reading', 'Comfortable reading print size', '/tests/near-vision', Icons.menu_book_outlined, Color(0xFF3F6FBF)),
  _TestEntry('Contrast Sensitivity', 'Detecting faint shapes', '/tests/contrast-sensitivity', Icons.contrast, Color(0xFF6B4EA6)),
  _TestEntry('Color Perception', 'Red-green color screening', '/tests/color-vision', Icons.palette_outlined, Color(0xFFE0632E)),
  _TestEntry('Reaction Time', 'Visual-motor response speed', '/tests/reaction-time', Icons.bolt_outlined, Color(0xFFEFB93C)),
];

const List<_TestEntry> _kPhase2Tests = [
  _TestEntry('Depth Perception', 'On-screen depth-cue judgment', '/tests/depth-perception', Icons.layers_outlined, Color(0xFF35C2C1)),
  _TestEntry('Peripheral Awareness', 'Noticing events near the edge of vision', '/tests/peripheral-vision', Icons.visibility_outlined, Color(0xFF4C9F70)),
  _TestEntry('Visual Attention', 'Finding an odd-colored target', '/tests/visual-attention', Icons.center_focus_strong_outlined, Color(0xFFC2559C)),
  _TestEntry('Visual Memory', 'Remembering colored items briefly', '/tests/visual-memory', Icons.grid_view_outlined, Color(0xFF7A5AF8)),
  _TestEntry('Motion Perception', 'Sensitivity to coherent motion', '/tests/motion-perception', Icons.blur_on, Color(0xFF3F8FBF)),
  _TestEntry('Eye Fatigue Questionnaire', 'Self-report of recent eye comfort', '/tests/eye-fatigue', Icons.self_improvement_outlined, Color(0xFFB7791F)),
];

/// SightScope home dashboard (Task.md §14/§16 / spec.md §4).
class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 168,
            backgroundColor: AppColors.brandSeed,
            foregroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.white),
            actionsIconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: const FlexibleSpaceBar(
              background: GradientHeroHeader(
                title: 'SightScope',
                subtitle: 'Your personal vision lab — test, measure, track.',
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.show_chart),
                tooltip: 'Trends',
                onPressed: () => context.push('/trends'),
              ),
              IconButton(
                icon: const Icon(Icons.person_outline),
                tooltip: 'Profile',
                onPressed: () => context.push('/profile'),
              ),
              IconButton(
                icon: const Icon(Icons.history),
                tooltip: 'History',
                onPressed: () => context.push('/history'),
              ),
              IconButton(
                icon: const Icon(Icons.menu_book),
                tooltip: 'Learn',
                onPressed: () => context.push('/education'),
              ),
              IconButton(
                icon: const Icon(Icons.straighten),
                tooltip: 'Calibrate',
                onPressed: () => context.push('/calibration'),
              ),
            ],
          ),
          SliverPadding(
            padding: AppSpacing.padScreen,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const _SectionHeader(
                  icon: Icons.grid_view_rounded,
                  title: 'Core screening',
                  subtitle: 'The essentials — acuity, contrast, color, and speed.',
                ),
                AppSpacing.gapSm,
                for (final entry in _kPhase1Tests) _TestCard(entry: entry),
                AppSpacing.gapLg,
                const _SectionHeader(
                  icon: Icons.auto_awesome_outlined,
                  title: 'Perception lab',
                  subtitle: 'Deeper, playful screens for depth, memory, and motion.',
                ),
                AppSpacing.gapSm,
                for (final entry in _kPhase2Tests) _TestCard(entry: entry),
                AppSpacing.gapLg,
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.brandSeed),
        AppSpacing.gapSm,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}

class _TestCard extends StatelessWidget {
  const _TestCard({required this.entry});

  final _TestEntry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppShapes.radiusLg),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppShapes.radiusLg),
          onTap: () => context.push(entry.route),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: entry.color.withValues(alpha: 0.15),
                  child: Icon(entry.icon, color: entry.color),
                ),
                AppSpacing.gapMd,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16)),
                      Text(entry.subtitle, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.outline),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
