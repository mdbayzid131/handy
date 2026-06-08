import 'package:get/get.dart';
import '../controllers/bottom_nab_bar.dart';
import '../../home/controllers/home_controller.dart';
import '../../sermons/controllers/sermons_controller.dart';
import '../../give/controllers/give_controller.dart';
import '../../events/controllers/events_controller.dart';
import '../../more/controllers/more_controller.dart';

class BottomNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavBarController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SermonsController());
    Get.lazyPut(() => GiveController());
    Get.lazyPut(() => EventsController());
    Get.lazyPut(() => MoreController());
  }
}
