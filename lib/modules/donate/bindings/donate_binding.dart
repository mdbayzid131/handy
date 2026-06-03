import 'package:get/get.dart';
import 'package:handy/modules/donate/controllers/donate_controller.dart';

class DonateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonateController>(() => DonateController());
  }
}
