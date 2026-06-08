import 'package:get/get.dart';

class NotificationController extends GetxController {
  var isSystemNotificationsEnabled = false.obs;

  var sundayServiceReminder = false.obs;
  var eventReminders = true.obs;
  var newAnnouncements = true.obs;
  var newSermons = false.obs;
  var prayerUpdates = true.obs;

  void toggleSystemNotifications() {
    isSystemNotificationsEnabled.value = !isSystemNotificationsEnabled.value;
  }
}
