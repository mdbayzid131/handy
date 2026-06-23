import 'package:get/get.dart';

import 'package:handy/modules/notifications/controllers/notifications_controller.dart';

class SettingsController extends GetxController {
  late final NotificationController notifCtrl;

  @override
  void onInit() {
    super.onInit();
    notifCtrl = Get.isRegistered<NotificationController>() 
        ? Get.find<NotificationController>() 
        : Get.put(NotificationController());
  }

  RxBool get sundayServiceReminder => notifCtrl.sundayServiceReminder;
  RxBool get eventReminders => notifCtrl.eventReminders;
  RxBool get newSermons => notifCtrl.newSermons;
  RxBool get prayerUpdates => notifCtrl.prayerUpdates;
  RxBool get devotionalUpdates => notifCtrl.devotionalUpdates;
  RxBool get customNotifications => notifCtrl.customNotifications;
}
