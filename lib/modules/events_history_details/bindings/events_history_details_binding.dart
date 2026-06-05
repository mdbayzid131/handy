import 'package:get/get.dart';
import '../controllers/events_history_details_controller.dart';

class EventsHistoryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventsHistoryDetailsController>(
      () => EventsHistoryDetailsController(),
    );
  }
}
