import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:handy/modules/events/controllers/events_controller.dart';

class EventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventsController());
  }
}