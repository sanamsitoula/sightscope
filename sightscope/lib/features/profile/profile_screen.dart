import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_spacing.dart';
import '../history/history_screen.dart';
import '../trends/trend_calculator.dart';

/// Separate profile dimensions (Task.md §16): each test's most recent
/// result shown independently. Never combined into one "vision score" or
/// "brain score".
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Could not load profile: $e')),
        data: (results) {
          final grouped = TrendCalculator.groupByTestId(results);
          if (grouped.isEmpty) {
            return const Padding(
              padding: AppSpacing.padScreen,
              child: Text('No results yet. Complete tests to build your profile.'),
            );
          }
          final testIds = grouped.keys.toList()..sort();
          return ListView.separated(
            padding: AppSpacing.padScreen,
            itemCount: testIds.length,
            separatorBuilder: (context, i) => AppSpacing.gapSm,
            itemBuilder: (context, i) {
              final latest = [...grouped[testIds[i]]!]..sort((a, b) => b.date.compareTo(a.date));
              final result = latest.first;
              return Card(
                child: ListTile(
                  title: Text(result.testId),
                  subtitle: Text(
                    'Score ${result.score.toStringAsFixed(2)} · confidence '
                    '${result.confidence.level.name} · ${result.date.toLocal()}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
