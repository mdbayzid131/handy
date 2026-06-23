import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:handy/core/services/auth_service.dart';
import 'package:handy/core/services/api_client.dart';
import 'package:handy/config/constants/api_constants.dart';
import 'package:handy/data/models/user_model.dart';
import 'package:handy/core/utils/helpers.dart';

class NotificationController extends GetxController {
  var isSystemNotificationsEnabled = false.obs;

  var sundayServiceReminder = true.obs;
  var eventReminders = true.obs;
  var newSermons = true.obs;
  var prayerUpdates = true.obs;
  var devotionalUpdates = true.obs;
  var customNotifications = true.obs;

  late final AuthService _authService;
  late final ApiClient _apiClient;
  bool _isInitializing = true;

  @override
  void onInit() {
    super.onInit();
    _authService = Get.find<AuthService>();
    _apiClient = Get.find<ApiClient>();
    
    _checkSystemPermissions();
    _loadPreferences();
    
    ever(sundayServiceReminder, (bool value) => _updatePreference('service_reminder', value));
    ever(newSermons, (bool value) => _updatePreference('sermon', value));
    ever(devotionalUpdates, (bool value) => _updatePreference('devotional', value));
    ever(customNotifications, (bool value) => _updatePreference('custom', value));
    ever(eventReminders, (bool value) => _updatePreference('event', value));
    ever(prayerUpdates, (bool value) => _updatePreference('prayer', value));
  }

  Future<void> _checkSystemPermissions() async {
    final status = await Permission.notification.status;
    isSystemNotificationsEnabled.value = status.isGranted;
  }

  Future<void> _loadPreferences() async {
    _isInitializing = true;
    final user = _authService.currentUser.value;
    
    if (user != null && user.notificationPreferences != null) {
      final prefs = user.notificationPreferences!;
      sundayServiceReminder.value = prefs.serviceReminder;
      newSermons.value = prefs.sermon;
      devotionalUpdates.value = prefs.devotional;
      customNotifications.value = prefs.custom;
      eventReminders.value = prefs.event;
      prayerUpdates.value = prefs.prayer;
    }
    
    // Ensure Firebase topic subscriptions match loaded preferences
    _syncTopic('service_reminder', sundayServiceReminder.value);
    _syncTopic('sermon', newSermons.value);
    _syncTopic('devotional', devotionalUpdates.value);
    _syncTopic('custom', customNotifications.value);
    
    _isInitializing = false;
  }

  Future<void> _syncTopic(String topic, bool subscribe) async {
    try {
      if (subscribe) {
        await FirebaseMessaging.instance.subscribeToTopic(topic);
      } else {
        await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
      }
    } catch (e) {
      Helpers.showDebugLog('Error syncing Firebase topic $topic: $e');
    }
  }

  Future<void> _updatePreference(String key, bool value) async {
    if (_isInitializing) return;
    
    // 1. Sync Firebase Topic if applicable
    if (['sermon', 'devotional', 'service_reminder', 'custom'].contains(key)) {
      await _syncTopic(key, value);
    }
    
    // 2. Update Backend
    if (_authService.isLoggedIn.value) {
      try {
        final prefs = NotificationPreferences(
          sermon: newSermons.value,
          devotional: devotionalUpdates.value,
          event: eventReminders.value,
          prayer: prayerUpdates.value,
          serviceReminder: sundayServiceReminder.value,
          custom: customNotifications.value,
        );

        final response = await _apiClient.patchData(
          ApiConstants.updateProfile, 
          { "notificationPreferences": prefs.toJson() }
        );

        if (response.statusCode != 200 && response.statusCode != 201) {
          Helpers.showDebugLog('Failed to update notification preferences on backend.');
        }
      } catch (e) {
        Helpers.showDebugLog('Error updating preferences on backend: $e');
      }
    }
  }

  void toggleSystemNotifications() async {
    await openAppSettings();
    Future.delayed(const Duration(seconds: 1), () {
      _checkSystemPermissions();
    });
  }
}
