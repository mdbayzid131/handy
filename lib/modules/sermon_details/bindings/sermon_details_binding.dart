import 'package:get/get.dart';
import '../controllers/sermon_details_controller.dart';

class SermondetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SermondetailsController>(() => SermondetailsController());
  }
}
