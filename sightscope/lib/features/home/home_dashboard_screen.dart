import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/gradient_hero_header.dart';
import '../history/history_screen.dart';

class _TestEntry {
  const _TestEntry(this.title, this.subtitle, this.route, this.icon);
  final String title;
  final String subtitle;
  final String route;
  final IconData icon;
}

// One icon family, one tone — tests are told apart by name and icon shape,
// not by a rainbow of badge colors (docs/brand.md §4).
const List<_TestEntry> _kPhase1Tests = [
  _TestEntry('Visual Acuity', 'Measure clarity at distance', '/tests/visual-acuity', Icons.remove_red_eye_outlined),
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

/// SightScope home dashboard — a personal instrument panel, not a grid of
/// colorful app tiles (docs/brand.md §13).
class HomeDashboardScreen extends ConsumerWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 148,
            backgroundColor: AppColors.deepInk,
            foregroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.white),
            actionsIconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: const FlexibleSpaceBar(
              background: GradientHeroHeader(
                title: 'SightScope',
                subtitle: 'Your personal vision laboratory.',
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
              IconButton(
                icon: const Icon(Icons.self_improvement_outlined),
                tooltip: 'Eye Wellness',
                onPressed: () => context.push('/eye-wellness'),
              ),
              IconButton(
                icon: const Icon(Icons.privacy_tip_outlined),
                tooltip: 'Privacy & Data',
                onPressed: () => context.push('/privacy'),
              ),
            ],
          ),
          SliverPadding(
            padding: AppSpacing.padScreen,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                historyAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (e, st) => const SizedBox.shrink(),
                  data: (results) => _LastSessionCard(
                    lastDate: results.isEmpty ? null : results.first.date,
                  ),
                ),
                AppSpacing.gapLg,
                const _TestRow(
                  entry: _TestEntry(
                    'Eye Wellness',
                    'Gentle reminders and a one-minute reset',
                    '/eye-wellness',
                    Icons.self_improvement_outlined,
                  ),
                ),
                AppSpacing.gapXl,
                const _SectionHeader(title: 'CORE SCREENING'),
                AppSpacing.gapSm,
                for (final entry in _kPhase1Tests) _TestRow(entry: entry),
                AppSpacing.gapLg,
                const _SectionHeader(title: 'PERCEPTION LAB'),
                AppSpacing.gapSm,
                for (final entry in _kPhase2Tests) _TestRow(entry: entry),
                AppSpacing.gapLg,
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _LastSessionCard extends StatelessWidget {
  const _LastSessionCard({required this.lastDate});

  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    final bool hasSession = lastDate != null;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => context.push(hasSession ? '/profile' : '/tests/visual-acuity'),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LAST SESSION', style: AppTypography.overline.copyWith(color: AppColors.sage)),
                      AppSpacing.gapXs,
                      Text(
                        hasSession ? _formatDate(lastDate!) : 'No sessions yet',
                        style: AppTypography.cardTitle,
                      ),
                      AppSpacing.gapXs,
                      Text(
                        hasSession ? 'Vision profile' : 'Start with Visual Acuity',
                        style: AppTypography.secondary,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward, color: AppColors.ink, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _formatDate(DateTime d) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTypography.overline.copyWith(color: AppColors.ink.withValues(alpha: 0.55)));
  }
}

class _TestRow extends StatelessWidget {
  const _TestRow({required this.entry});

  final _TestEntry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => context.push(entry.route),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Icon(entry.icon, size: 20, color: AppColors.ink),
                AppSpacing.gapMd,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.title, style: AppTypography.cardTitle),
                      Text(entry.subtitle, style: AppTypography.secondary),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward, size: 18, color: AppColors.ink),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
