import 'package:get/get.dart';
import 'package:handy/modules/watch_live/controllers/watch_live_controller.dart';

class WatchLiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WatchLiveController>(() => WatchLiveController());
  }
}
