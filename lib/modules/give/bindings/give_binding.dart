import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:handy/modules/give/controllers/give_controller.dart';

class GiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GiveController());
  }
}