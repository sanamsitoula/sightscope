import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

/// Thin wrapper over `flutter_local_notifications`. EyeGuard uses this only
/// for gentle, dismissible, non-repeating reminder notifications — never
/// scheduled/recurring background alarms, and never anything that could
/// interrupt a call or full-screen video with a blocking dialog (this only
/// ever posts a normal notification, which the OS itself won't show over
/// an active full-screen app).
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const String _channelId = 'eye_wellness_reminders';

  Future<void> init() async {
    if (_initialized) return;
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _plugin.initialize(
      const InitializationSettings(android: androidSettings, iOS: iosSettings),
    );
    _initialized = true;
  }

  /// Whether the OS-level notification permission is currently granted.
  Future<bool> hasPermission() async => (await Permission.notification.status).isGranted;

  /// Requests the notification permission (Android 13+ / iOS). Returns
  /// whether it ended up granted.
  Future<bool> requestPermission() async {
    final PermissionStatus status = await Permission.notification.request();
    return status.isGranted;
  }

  Future<void> showReminder({required String title, required String body}) async {
    if (!_initialized) await init();
    if (!await hasPermission()) return;
    await _plugin.show(
      0,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          'Eye wellness reminders',
          channelDescription: 'Gentle, occasional reminders to rest your eyes.',
          importance: Importance.low,
          priority: Priority.low,
          category: AndroidNotificationCategory.reminder,
        ),
        iOS: DarwinNotificationDetails(presentBanner: true, presentSound: false),
      ),
    );
  }
}
