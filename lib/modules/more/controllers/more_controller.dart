import 'package:get/get.dart';
import 'package:handy/core/services/api_client.dart';
import 'package:handy/core/utils/helpers.dart';
import 'package:handy/config/constants/api_constants.dart';
import 'package:handy/data/models/contact_mission_model.dart';

class MoreController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();
  var currentIndex = 0;

  final isLoading = false.obs;
  final contactMission = Rxn<ContactMissionModel>();

  @override
  void onInit() {
    super.onInit();
    fetchContactAndMission();
  }

  Future<void> fetchContactAndMission() async {
    if (contactMission.value == null) isLoading.value = true;
    try {
      final response = await apiClient.getData(ApiConstants.contactAndMission);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          contactMission.value = ContactMissionModel.fromJson(response.data['data']);
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching contact & mission: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await fetchContactAndMission();
  }
}