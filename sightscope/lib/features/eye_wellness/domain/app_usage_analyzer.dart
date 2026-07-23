import '../data/app_usage_datasource.dart';

class AppUsageInsight {
  const AppUsageInsight({required this.topApps, required this.totalScreenTime});
  final List<AppUsageEntry> topApps;
  final Duration totalScreenTime;
}

/// Deterministic summary over raw usage entries — no AI, no network,
/// matching ai.md's "deterministic statistics engine" rule.
class AppUsageAnalyzer {
  const AppUsageAnalyzer._();

  static AppUsageInsight analyze(List<AppUsageEntry> entries, {int topN = 5}) {
    final Duration total = entries.fold(Duration.zero, (sum, e) => sum + e.duration);
    final List<AppUsageEntry> sorted = [...entries]
      ..sort((a, b) => b.duration.compareTo(a.duration));
    return AppUsageInsight(topApps: sorted.take(topN).toList(), totalScreenTime: total);
  }

  /// Best-effort human-readable label from a package name (e.g.
  /// `com.google.android.youtube` -> `Youtube`). Android doesn't expose the
  /// installed app's display label through `UsageStatsManager` without an
  /// additional package-listing permission/dependency, so this is a
  /// heuristic, not the app's real name.
  static String friendlyName(String packageName) {
    final List<String> parts = packageName.split('.');
    if (parts.isEmpty) return packageName;
    final String last = parts.last;
    if (last.isEmpty) return packageName;
    return last[0].toUpperCase() + last.substring(1);
  }
}
