import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handy/core/services/storage_service.dart';
import 'package:handy/core/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'app.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message: ${message.messageId}");

  // If this is a data-only payload, we need to show the notification manually
  if (message.notification == null && message.data.isNotEmpty) {
    final title = message.data['title'] ?? message.data['subject'] ?? 'New Notification';
    final body = message.data['body'] ?? message.data['message'] ?? '';

    final plugin = FlutterLocalNotificationsPlugin();
    await plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );

    await plugin.show(
      message.hashCode,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: jsonEncode(message.data),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Disable screen rotation (Portrait only)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize services here
  await StorageService.init();
  await Get.putAsync<NotificationService>(() async => await NotificationService().init());

  runApp(const MyApp());
}
