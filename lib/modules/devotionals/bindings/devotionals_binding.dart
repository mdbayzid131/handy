import 'package:get/get.dart';
import 'package:handy/modules/devotionals/controllers/devotionals_controller.dart';

class DevotionalsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DevotionalsController>(() => DevotionalsController());
  }
}
