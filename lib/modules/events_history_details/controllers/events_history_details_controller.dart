import 'package:get/get.dart';
import '../../../data/models/events_model.dart';

class EventsHistoryDetailsController extends GetxController {
  late EventModel event;

  @override
  void onInit() {
    super.onInit();
    event = Get.arguments as EventModel;
  }
}
