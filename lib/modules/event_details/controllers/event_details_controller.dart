import 'package:get/get.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import '../../../core/services/api_client.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/events_model.dart';
import '../../../config/constants/api_constants.dart';
import 'package:handy/modules/events/controllers/events_controller.dart';
import 'package:handy/modules/home/controllers/home_controller.dart';

class EventDetailsController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();

  late Rx<EventModel> event;
  final isRSVPd = false.obs;
  final isLoading = false.obs;
  final isRsvpLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final initialEvent = Get.arguments as EventModel;
    event = initialEvent.obs;
    isRSVPd.value = initialEvent.hasRsvp;
    fetchEventDetails();
  }

  Future<void> fetchEventDetails() async {
    isLoading.value = true;
    try {
      final response = await apiClient.getData(
        ApiConstants.eventDetails(event.value.id),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          event.value = EventModel.fromJson(response.data['data']);
          isRSVPd.value = event.value.hasRsvp;
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching event details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleRSVP() async {
    if (isRsvpLoading.value) return;
    isRsvpLoading.value = true;
    try {
      final response = await apiClient.postData(
        ApiConstants.eventRsvp(event.value.id),
        {},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          final data = response.data['data'];
          event.value = event.value.copyWith(
            hasRsvp: data['hasRsvp'] ?? event.value.hasRsvp,
            attendingCount:
                data['attendingCount'] ?? event.value.attendingCount,
          );
          isRSVPd.value = event.value.hasRsvp;
          Helpers.showSuccess(
            response.data['message'] ?? 'RSVP status updated',
          );

          // Sync with EventsController
          if (Get.isRegistered<EventsController>()) {
            final eventsController = Get.find<EventsController>();
            final index = eventsController.allEvents.indexWhere(
              (e) => e.id == event.value.id,
            );
            if (index != -1) {
              eventsController.allEvents[index] = event.value;
            }
          }

          // Sync with HomeController
          if (Get.isRegistered<HomeController>()) {
            final homeController = Get.find<HomeController>();
            final index = homeController.latestEvents.indexWhere(
              (e) => e.id == event.value.id,
            );
            if (index != -1) {
              homeController.latestEvents[index] = event.value;
            }
          }
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error updating RSVP: $e');
      Helpers.showError('Failed to update RSVP status');
    } finally {
      isRsvpLoading.value = false;
    }
  }

  void addToCalendar() {
    try {
      DateTime startDate;
      if (event.value.dateISO.isNotEmpty) {
        startDate = DateTime.parse(event.value.dateISO).toLocal();
      } else {
        startDate = DateTime.now();
      }

      if (event.value.time.isNotEmpty) {
        try {
          // Example time format: "10:00 AM" or "14:30"
          final timeStr = event.value.time.trim();
          final isAmPm = timeStr.toLowerCase().contains('m');
          
          // We can try parsing using basic logic or intl
          // A simple generic regex to extract hours and minutes
          final RegExp timeRegex = RegExp(r'(\d{1,2}):(\d{2})');
          final match = timeRegex.firstMatch(timeStr);
          
          if (match != null) {
            int hour = int.parse(match.group(1)!);
            int minute = int.parse(match.group(2)!);
            
            if (isAmPm) {
              final isPm = timeStr.toLowerCase().contains('p');
              if (isPm && hour < 12) hour += 12;
              if (!isPm && hour == 12) hour = 0;
            }
            
            startDate = DateTime(
              startDate.year,
              startDate.month,
              startDate.day,
              hour,
              minute,
            );
          }
        } catch (e) {
          Helpers.showDebugLog('Error parsing event time: $e');
        }
      }

      final Event calEvent = Event(
        title: event.value.title,
        description: event.value.description ?? 'Church Event',
        location: event.value.location,
        startDate: startDate,
        endDate: startDate.add(const Duration(hours: 2)),
        allDay: false,
      );

      Add2Calendar.addEvent2Cal(calEvent);
    } catch (e) {
      Helpers.showDebugLog('Error adding to calendar: $e');
      Helpers.showError('Failed to add event to calendar');
    }
  }
}
