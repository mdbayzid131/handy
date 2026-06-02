import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:handy/modules/sermons/controllers/sermons_controller.dart';

class SermonsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SermonsController());
  }
}