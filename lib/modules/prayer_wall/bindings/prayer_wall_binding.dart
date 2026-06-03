import 'package:get/get.dart';
import 'package:handy/modules/prayer_wall/controllers/prayer_wall_controller.dart';

class PrayerWallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrayerWallController>(() => PrayerWallController());
  }
}
