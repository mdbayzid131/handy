import 'package:get/get.dart';

class NotificationController extends GetxController {
  var isSystemNotificationsEnabled = false.obs;

  var sundayServiceReminder = true.obs;
  var eventReminders = true.obs;
  var newAnnouncements = true.obs;
  var newSermons = true.obs;
  var prayerUpdates = false.obs;

  void toggleSystemNotifications() {
    isSystemNotificationsEnabled.value = !isSystemNotificationsEnabled.value;
  }
}
