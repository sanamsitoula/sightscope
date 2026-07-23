import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_spacing.dart';

class _TestEntry {
  const _TestEntry(this.title, this.subtitle, this.route, this.icon);
  final String title;
  final String subtitle;
  final String route;
  final IconData icon;
}

const List<_TestEntry> _kPhase1Tests = [
  _TestEntry('Visual Acuity', 'How sharply you see fine detail', '/tests/visual-acuity', Icons.remove_red_eye_outlined),
  _TestEntry('Near Vision & Reading', 'Comfortable reading print size', '/tests/near-vision', Icons.menu_book_outlined),
  _TestEntry('Contrast Sensitivity', 'Detecting faint shapes', '/tests/contrast-sensitivity', Icons.contrast),
  _TestEntry('Color Perception', 'Red-green color screening', '/tests/color-vision', Icons.palette_outlined),
  _TestEntry('Reaction Time', 'Visual-motor response speed', '/tests/reaction-time', Icons.bolt_outlined),
];

const List<_TestEntry> _kPhase2Tests = [
  _TestEntry('Depth Perception', 'On-screen depth-cue judgment', '/tests/depth-perception', Icons.layers_outlined),
  _TestEntry('Peripheral Awareness', 'Noticing events near the edge of vision', '/tests/peripheral-vision', Icons.visibility_outlined),
  _TestEntry('Visual Attention', 'Finding an odd-colored target', '/tests/visual-attention', Icons.center_focus_strong_outlined),
  _TestEntry('Visual Memory', 'Remembering colored items briefly', '/tests/visual-memory', Icons.grid_view_outlined),
  _TestEntry('Motion Perception', 'Sensitivity to coherent motion', '/tests/motion-perception', Icons.blur_on),
  _TestEntry('Eye Fatigue Questionnaire', 'Self-report of recent eye comfort', '/tests/eye-fatigue', Icons.self_improvement_outlined),
];

/// SightScope home dashboard (Task.md §14/§16 / spec.md §4).
class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SightScope'),
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
      body: ListView(
        padding: AppSpacing.padScreen,
        children: [
          Text('Core screening', style: Theme.of(context).textTheme.titleLarge),
          AppSpacing.gapSm,
          for (final entry in _kPhase1Tests) _TestCard(entry: entry),
          AppSpacing.gapLg,
          Text('Perception lab', style: Theme.of(context).textTheme.titleLarge),
          AppSpacing.gapSm,
          for (final entry in _kPhase2Tests) _TestCard(entry: entry),
        ],
      ),
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
      child: Card(
        child: ListTile(
          leading: Icon(entry.icon),
          title: Text(entry.title),
          subtitle: Text(entry.subtitle),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push(entry.route),
        ),
      ),
    );
  }
}
