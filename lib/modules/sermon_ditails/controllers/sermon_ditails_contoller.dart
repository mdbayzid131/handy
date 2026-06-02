import 'package:get/get.dart';
import '../../../data/models/sermons_model.dart';

class SermonDitailsController extends GetxController {
  late Sermon sermon;

  @override
  void onInit() {
    super.onInit();
    sermon = Get.arguments as Sermon? ?? 
      Sermon(id: '0', category: 'UNKNOWN', title: 'No Sermon', pastor: 'Unknown', date: '', duration: '');
  }
}
