import 'package:get/get.dart';
import 'package:handy/core/services/api_client.dart';
import 'package:handy/core/utils/helpers.dart';
import 'package:handy/config/constants/api_constants.dart';
import 'package:handy/data/models/devotional_model.dart';

class DevotionalsDetailsController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();

  final isLoading = false.obs;
  final isMarkingRead = false.obs;
  final devotional = Rxn<DevotionalModel>();
  String? devotionalId;

  @override
  void onInit() {
    super.onInit();
    devotionalId = Get.arguments as String?;
    if (devotionalId != null) {
      fetchDevotionalById(devotionalId!);
    } else {
      fetchTodayDevotional();
    }
  }

  Future<void> fetchTodayDevotional() async {
    isLoading.value = true;
    try {
      final response = await apiClient.getData(ApiConstants.devotionalToday);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          devotional.value = DevotionalModel.fromJson(response.data['data']);
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching today devotional: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDevotionalById(String id) async {
    isLoading.value = true;
    try {
      final response = await apiClient.getData(ApiConstants.devotionalById(id));
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          devotional.value = DevotionalModel.fromJson(response.data['data']);
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching devotional by id: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAsRead() async {
    if (devotional.value?.id == null || isMarkingRead.value) return;

    isMarkingRead.value = true;
    try {
      final response = await apiClient.postData(
        ApiConstants.markDevotionalRead(devotional.value!.id!),
        {},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Update local state
        final current = devotional.value;
        if (current != null) {
          devotional.value = DevotionalModel(
            id: current.id,
            title: current.title,
            dayLabel: current.dayLabel,
            date: current.date,
            dateISO: current.dateISO,
            scriptureRef: current.scriptureRef,
            scriptureQuote: current.scriptureQuote,
            reflection: current.reflection,
            reflectionPreview: current.reflectionPreview,
            prayer: current.prayer,
            isRead: true, // Marked as read
          );
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error marking devotional as read: $e');
    } finally {
      isMarkingRead.value = false;
    }
  }

  Future<void> refreshData() async {
    if (devotionalId != null) {
      await fetchDevotionalById(devotionalId!);
    } else {
      await fetchTodayDevotional();
    }
  }
}
