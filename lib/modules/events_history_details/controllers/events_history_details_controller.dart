import 'package:get/get.dart';
import '../../../core/services/api_client.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/events_model.dart';
import '../../../config/constants/api_constants.dart';

class EventsHistoryDetailsController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();
  
  late Rx<EventModel> event;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final initialEvent = Get.arguments as EventModel;
    event = initialEvent.obs;
    fetchEventDetails();
  }

  Future<void> fetchEventDetails() async {
    isLoading.value = true;
    try {
      final response = await apiClient.getData(ApiConstants.eventDetails(event.value.id));
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          event.value = EventModel.fromJson(response.data['data']);
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching history event details: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
