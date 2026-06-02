import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:handy/modules/more/controllers/more_controller.dart';

class MoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MoreController());
  }
}