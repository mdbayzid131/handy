import 'package:get/get.dart';
import '../controllers/sermon_ditails_contoller.dart';

class SermonDitailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SermonDitailsController>(() => SermonDitailsController());
  }
}
