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

const List<_TestEntry> _kTests = [
  _TestEntry('Visual Acuity', 'How sharply you see fine detail', '/tests/visual-acuity', Icons.remove_red_eye_outlined),
  _TestEntry('Near Vision & Reading', 'Comfortable reading print size', '/tests/near-vision', Icons.menu_book_outlined),
  _TestEntry('Contrast Sensitivity', 'Detecting faint shapes', '/tests/contrast-sensitivity', Icons.contrast),
  _TestEntry('Color Perception', 'Red-green color screening', '/tests/color-vision', Icons.palette_outlined),
  _TestEntry('Reaction Time', 'Visual-motor response speed', '/tests/reaction-time', Icons.bolt_outlined),
];

/// SightScope home dashboard (Task.md §14 / spec.md §4).
class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SightScope'),
        actions: [
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
      body: ListView.separated(
        padding: AppSpacing.padScreen,
        itemCount: _kTests.length,
        separatorBuilder: (context, i) => AppSpacing.gapSm,
        itemBuilder: (context, i) {
          final entry = _kTests[i];
          return Card(
            child: ListTile(
              leading: Icon(entry.icon),
              title: Text(entry.title),
              subtitle: Text(entry.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(entry.route),
            ),
          );
        },
      ),
    );
  }
}
