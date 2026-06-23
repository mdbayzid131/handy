import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/logger.dart';
import '../../config/constants/api_constants.dart';
import 'api_client.dart';
import 'package:permission_handler/permission_handler.dart';

/// ===================== NOTIFICATION SERVICE =====================
/// Service for Push Notifications (FCM) and Local Notifications (Downloads).
class NotificationService extends GetxService {
  static NotificationService get to => Get.find();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  int _notificationId = 0;

  // Android Notification Channels
  final AndroidNotificationChannel _fcmChannel =
      const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
      );

  final AndroidNotificationChannel _downloadChannel = const AndroidNotificationChannel(
    'download_channel',
    'Downloads',
    description: 'Notifications for downloaded files',
    importance: Importance.max,
  );

  RemoteMessage? _initialMessage;
  bool _hasHandledInitialMessage = false;

  Future<NotificationService> init() async {
    await _requestPermission();
    await _initLocalNotifications();
    await _setupFCMListeners();
    _handleFCMToken(); // Run in background so ApiClient can initialize
    return this;
  }

  Future<void> _requestPermission() async {
    if (Platform.isAndroid) {
      await Permission.notification.request();
    }
    
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      AppLogger.debug('User granted notification permission');
    } else {
      AppLogger.debug(
        'User declined or has not accepted notification permissions',
      );
    }
  }

  Future<void> _initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      'ic_notification',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    // Create channels on Android
    if (Platform.isAndroid) {
      final androidImplementation = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      await androidImplementation?.createNotificationChannel(_fcmChannel);
      await androidImplementation?.createNotificationChannel(_downloadChannel);
    }
  }

  Future<void> _onNotificationTap(NotificationResponse response) async {
    if (response.payload == null || response.payload!.isEmpty) return;

    // Check if payload is JSON (from FCM routing)
    try {
      final data = jsonDecode(response.payload!);
      if (data is Map) {
        _handleRouting(Map<String, dynamic>.from(data));
        return;
      }
    } catch (_) {
      // If not JSON, it might be a file path from a download notification
      try {
        await OpenFile.open(response.payload);
      } catch (e) {
        AppLogger.debug('Error opening file from notification: $e');
      }
    }
  }

  Future<void> _setupFCMListeners() async {
    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AppLogger.debug('Got a message whilst in the foreground!');
      if (message.notification != null) {
        _showFCMNotification(message);
      }
    });

    // Background/Terminated tapped messages
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleRoutingFromMessage(message);
    });

    // Terminated state initial message
    _initialMessage = await _fcm.getInitialMessage();
    // We do NOT route immediately. We wait for SplashController to finish and call handlePendingInitialMessage()
  }

  void handlePendingInitialMessage() {
    if (_initialMessage != null && !_hasHandledInitialMessage) {
      _hasHandledInitialMessage = true;
      _handleRoutingFromMessage(_initialMessage!);
    }
  }

  void _showFCMNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      _plugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _fcmChannel.id,
            _fcmChannel.name,
            channelDescription: _fcmChannel.description,
            icon: 'ic_notification',
            largeIcon: const DrawableResourceAndroidBitmap('ic_notification'),
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        // Encode data map as payload for routing on tap
        payload: jsonEncode(message.data),
      );
    }
  }

  void _handleRoutingFromMessage(RemoteMessage message) {
    _handleRouting(message.data);
  }

  void _handleRouting(Map<String, dynamic> data) {
    AppLogger.debug("Handling notification routing with payload: $data");

    if (data.containsKey('type')) {
      final type = data['type'];
      if (type == 'sermon') {
        final id = data['id'];
        if (id != null) {
          Get.toNamed('/sermon-details', arguments: {'id': id});
        }
      } else if (type == 'service_reminder' || type == 'custom') {
        Get.offAllNamed('/bottom-nav-bar');
      }
    } else if (data.containsKey('route')) {
      final route = data['route'] as String?;
      if (route != null && route.isNotEmpty) {
        AppLogger.debug("Navigating to route from notification: $route");
        Get.toNamed(route);
      }
    }
  }

  Future<void> _handleFCMToken() async {
    try {
      String? token = await _fcm.getToken();
      if (token != null) {
        AppLogger.debug("FCM Token: $token");
        await _sendTokenToBackend(token);
      }

      _fcm.onTokenRefresh.listen((newToken) {
        AppLogger.debug("FCM Token Refreshed: $newToken");
        _sendTokenToBackend(newToken);
      });
    } catch (e) {
      AppLogger.debug("Error fetching FCM token: $e");
    }
  }

  Future<void> _sendTokenToBackend(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final platform = Platform.isIOS ? 'ios' : 'android';

      // Wait until ApiClient is registered by InitialBinding
      while (!Get.isRegistered<ApiClient>()) {
        await Future.delayed(const Duration(milliseconds: 500));
      }

      final apiClient = Get.find<ApiClient>();

      final response = await apiClient.postData(ApiConstants.deviceToken, {
        "token": token,
        "platform": platform,
        "user": null, // Guest users included
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppLogger.debug('Token successfully saved to backend!');
        await prefs.setString('fcm_token', token);
      }
    } catch (e) {
      AppLogger.debug("Failed to send token to backend: $e");
    }
  }

  // ===================== LEGACY METHODS FOR DOWNLOADS =====================

  Future<void> showDownloadNotification({
    required String filePath,
    required String fileName,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      _downloadChannel.id,
      _downloadChannel.name,
      channelDescription: _downloadChannel.description,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    await _plugin.show(
      _notificationId++,
      'Download Complete',
      '$fileName has been downloaded.',
      NotificationDetails(android: androidDetails),
      payload: filePath,
    );
  }

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

    await _plugin.show(
      _notificationId++,
      title,
      body,
      NotificationDetails(android: androidDetails),
      payload: payload,
    );
  }

  Future<void> cancel(int id) => _plugin.cancel(id);
  Future<void> cancelAll() => _plugin.cancelAll();
}
