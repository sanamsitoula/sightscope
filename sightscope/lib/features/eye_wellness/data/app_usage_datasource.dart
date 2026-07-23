import 'dart:io';

import 'package:usage_stats/usage_stats.dart';

class AppUsageEntry {
  const AppUsageEntry({required this.packageName, required this.duration});
  final String packageName;
  final Duration duration;
}

/// Android-only wrapper over `UsageStatsManager` (via the `usage_stats`
/// plugin). This is the one part of EyeGuard that needs a special,
/// Settings-only permission — there is no runtime dialog for it, and it
/// does not exist on iOS at all (see docs/brand.md's EyeGuard section).
class AppUsageDataSource {
  const AppUsageDataSource();

  bool get isSupported => Platform.isAndroid;

  Future<bool> hasPermission() async {
    if (!isSupported) return false;
    return await UsageStats.checkUsagePermission() ?? false;
  }

  /// Opens the OS "Usage access" settings screen for the user to grant
  /// access manually. There is no way to request this permission inline.
  Future<void> openPermissionSettings() async {
    if (!isSupported) return;
    await UsageStats.grantUsagePermission();
  }

  /// Per-app foreground time so far today, sorted by duration descending.
  Future<List<AppUsageEntry>> todayUsage() async {
    if (!isSupported) return const [];
    final DateTime now = DateTime.now();
    final DateTime startOfDay = DateTime(now.year, now.month, now.day);
    final List<UsageInfo> stats = await UsageStats.queryUsageStats(startOfDay, now);

    final List<AppUsageEntry> entries = [];
    for (final UsageInfo info in stats) {
      final int ms = int.tryParse(info.totalTimeInForeground ?? '0') ?? 0;
      if (ms <= 0) continue;
      entries.add(AppUsageEntry(
        packageName: info.packageName ?? 'unknown',
        duration: Duration(milliseconds: ms),
      ));
    }
    entries.sort((a, b) => b.duration.compareTo(a.duration));
    return entries;
  }
}
