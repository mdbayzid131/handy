import 'package:get/get.dart';
import '../controllers/events_history_controller.dart';

class EventsHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventsHistoryController>(() => EventsHistoryController());
  }
}
