import 'package:get/get.dart';
import '../../../data/models/events_model.dart';

class EventDetailsController extends GetxController {
  late EventModel event;
  final isRSVPd = false.obs;

  @override
  void onInit() {
    super.onInit();
    event = Get.arguments as EventModel;
  }

  void toggleRSVP() {
    isRSVPd.value = !isRSVPd.value;
    if (isRSVPd.value) {
      event = EventModel(
        id: event.id,
        category: event.category,
        title: event.title,
        date: event.date,
        time: event.time,
        location: event.location,
        attendeeCount: event.attendeeCount + 1,
        description: event.description,
      );
    } else {
      event = EventModel(
        id: event.id,
        category: event.category,
        title: event.title,
        date: event.date,
        time: event.time,
        location: event.location,
        attendeeCount: event.attendeeCount - 1,
        description: event.description,
      );
    }
  }
}
