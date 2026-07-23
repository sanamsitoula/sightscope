import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_spacing.dart';
import '../history/history_screen.dart';
import 'trend_bar_chart.dart';
import 'trend_calculator.dart';

String _neutralDirectionText(TrendDirection direction) => switch (direction) {
      TrendDirection.higher => 'Your most recent result was higher than your first recorded result.',
      TrendDirection.lower => 'Your most recent result was lower than your first recorded result.',
      TrendDirection.stable => 'Your most recent result was similar to your first recorded result.',
      TrendDirection.insufficientData => 'Only one result so far — complete this test again to see a trend.',
    };

/// Personal trends (Task.md §16): baseline vs. current per test dimension,
/// each shown separately with its own confidence — never combined into one
/// score, and always in neutral, non-alarmist language.
class TrendsScreen extends ConsumerWidget {
  const TrendsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Trends')),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Could not load trends: $e')),
        data: (results) {
          final grouped = TrendCalculator.groupByTestId(results);
          if (grouped.isEmpty) {
            return const Padding(
              padding: AppSpacing.padScreen,
              child: Text('No results yet. Complete a test to start building a trend.'),
            );
          }
          final testIds = grouped.keys.toList()..sort();
          return ListView.separated(
            padding: AppSpacing.padScreen,
            itemCount: testIds.length,
            separatorBuilder: (context, i) => AppSpacing.gapMd,
            itemBuilder: (context, i) {
              final summary = TrendCalculator.summarize(testIds[i], grouped[testIds[i]]!);
              if (summary == null) return const SizedBox.shrink();
              return Card(
                child: Padding(
                  padding: AppSpacing.padScreen,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(summary.testId, style: Theme.of(context).textTheme.titleLarge),
                      AppSpacing.gapSm,
                      TrendBarChart(baseline: summary.baseline.score, current: summary.current.score),
                      AppSpacing.gapSm,
                      Text(_neutralDirectionText(summary.direction)),
                      Text('Confidence: ${summary.current.confidence.level.name}'),
                      Text('Based on ${summary.sampleCount} recorded result(s).'),
                      Text(
                        'Test conditions can vary between sessions and affect comparability.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
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
