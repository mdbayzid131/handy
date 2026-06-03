import 'package:get/get.dart';
import 'package:handy/modules/devotionals_details/controllers/devotionals_details_controller.dart';

class DevotionalsDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DevotionalsDetailsController>(
      () => DevotionalsDetailsController(),
    );
  }
}
