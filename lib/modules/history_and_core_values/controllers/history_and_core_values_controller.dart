import 'package:get/get.dart';
import 'package:handy/core/services/api_client.dart';
import 'package:handy/core/utils/helpers.dart';
import 'package:handy/config/constants/api_constants.dart';

class HistoryAndCoreValuesController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();

  final isLoading = false.obs;
  final content = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchChurchInfo();
  }

  Future<void> fetchChurchInfo() async {
    isLoading.value = true;
    try {
      final response = await apiClient.getData(ApiConstants.churchInfo);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null && response.data['data']['content'] != null) {
          String rawContent = response.data['data']['content'];
          // Remove inline background-color and color to let the app theme handle it
          rawContent = rawContent.replaceAll(RegExp(r'background-color:[^;"]+;?'), '');
          rawContent = rawContent.replaceAll(RegExp(r'color:[^;"]+;?'), '');
          content.value = rawContent;
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching church info: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await fetchChurchInfo();
  }
}
