import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_usage_datasource.dart';
import 'notification_service.dart';

final Provider<AppUsageDataSource> appUsageDataSourceProvider =
    Provider<AppUsageDataSource>((ref) => const AppUsageDataSource());

final Provider<NotificationService> notificationServiceProvider =
    Provider<NotificationService>((ref) => NotificationService.instance);

/// Whether the Android "Usage access" special permission is currently
/// granted. Re-evaluate with `ref.invalidate(usageAccessGrantedProvider)`
/// after sending the user to the settings screen.
final FutureProvider<bool> usageAccessGrantedProvider = FutureProvider<bool>((ref) {
  return ref.watch(appUsageDataSourceProvider).hasPermission();
});

/// Today's per-app foreground time, only meaningful when
/// [usageAccessGrantedProvider] is true.
final FutureProvider<List<AppUsageEntry>> todayAppUsageProvider =
    FutureProvider<List<AppUsageEntry>>((ref) {
  return ref.watch(appUsageDataSourceProvider).todayUsage();
});
