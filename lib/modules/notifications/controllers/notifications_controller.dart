import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  var isSystemNotificationsEnabled = false.obs;

  var sundayServiceReminder = true.obs;
  var eventReminders = true.obs;
  var newAnnouncements = true.obs;
  var newSermons = true.obs;
  var prayerUpdates = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkSystemPermissions();
    _loadPreferences();
    
    ever(sundayServiceReminder, (bool value) => _updateTopic('service_reminder', value));
    ever(newSermons, (bool value) => _updateTopic('sermon', value));
  }

  Future<void> _checkSystemPermissions() async {
    final status = await Permission.notification.status;
    isSystemNotificationsEnabled.value = status.isGranted;
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    sundayServiceReminder.value = prefs.getBool('topic_service_reminder') ?? true;
    newSermons.value = prefs.getBool('topic_sermon') ?? true;
    
    // Ensure subscriptions match loaded preferences
    _updateTopic('service_reminder', sundayServiceReminder.value);
    _updateTopic('sermon', newSermons.value);
    
    // Always subscribe to custom topic
    await FirebaseMessaging.instance.subscribeToTopic('custom');
  }

  Future<void> _updateTopic(String topic, bool subscribe) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('topic_$topic', subscribe);
    
    if (subscribe) {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    }
  }

  void toggleSystemNotifications() async {
    await openAppSettings();
    // Give user time to return to app before rechecking
    Future.delayed(const Duration(seconds: 1), () {
      _checkSystemPermissions();
    });
  }
}
