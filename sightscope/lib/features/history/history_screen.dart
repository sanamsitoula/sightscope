import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/storage/database_provider.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/test_engine/domain/test_result.dart';
import '../../shared/test_engine/engine/test_result_repository.dart';

final FutureProvider<List<TestResult>> historyProvider = FutureProvider<List<TestResult>>((ref) {
  final repository = TestResultRepository(ref.watch(appDatabaseProvider));
  return repository.loadAll();
});

/// Local, on-device result history (Task.md §14 / spec.md §19). No network
/// calls — everything comes from the Drift-backed [TestResultRepository].
class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Could not load history: $e')),
        data: (results) {
          if (results.isEmpty) {
            return const Padding(
              padding: AppSpacing.padScreen,
              child: Text('No results yet. Complete a test to see it here.'),
            );
          }
          return ListView.separated(
            padding: AppSpacing.padScreen,
            itemCount: results.length,
            separatorBuilder: (context, i) => AppSpacing.gapSm,
            itemBuilder: (context, i) {
              final r = results[i];
              return Card(
                child: ListTile(
                  title: Text(r.testId),
                  subtitle: Text(
                    '${r.date.toLocal()} · score ${r.score.toStringAsFixed(2)} · '
                    'confidence ${r.confidence.level.name}',
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
