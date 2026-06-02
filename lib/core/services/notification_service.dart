import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import '../utils/logger.dart';

/// ===================== NOTIFICATION SERVICE =====================
/// Singleton service for local notifications (download alerts, reminders, etc.).
/// Requires: flutter_local_notifications, open_file
class NotificationService {
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// Unique notification ID counter
  int _notificationId = 0;

  /// Initialize the notification plugin with platform-specific settings
  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  /// Handle notification tap — opens file if payload is a file path
  Future<void> _onNotificationTap(NotificationResponse response) async {
    if (response.payload == null || response.payload!.isEmpty) return;

    try {
      await OpenFile.open(response.payload);
    } catch (e) {
      AppLogger.debug('Error opening file from notification: $e');
    }
  }

  /// Show a download-complete notification that opens the file on tap
  Future<void> showDownloadNotification({
    required String filePath,
    required String fileName,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'download_channel',
      'Downloads',
      channelDescription: 'Notifications for downloaded files',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const details = NotificationDetails(android: androidDetails);

    await _plugin.show(
      _notificationId++,
      'Download Complete',
      '$fileName has been downloaded.',
      details,
      payload: filePath,
    );
  }

  /// Show a generic notification
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
    String channelId = 'general_channel',
    String channelName = 'General',
  }) async {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );

    final details = NotificationDetails(android: androidDetails);

    await _plugin.show(
      _notificationId++,
      title,
      body,
      details,
      payload: payload,
    );
  }

  /// Cancel a specific notification
  Future<void> cancel(int id) => _plugin.cancel(id);

  /// Cancel all notifications
  Future<void> cancelAll() => _plugin.cancelAll();
}
