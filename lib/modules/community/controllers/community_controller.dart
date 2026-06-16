import 'package:get/get.dart';
import 'package:handy/core/services/api_client.dart';
import 'package:handy/core/utils/helpers.dart';
import 'package:handy/config/constants/api_constants.dart';
import 'package:handy/data/models/community_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();

  final isLoading = false.obs;
  final communityList = <CommunityModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCommunity();
  }

  Future<void> fetchCommunity() async {
    isLoading.value = true;
    try {
      final response = await apiClient.getData(ApiConstants.communityList);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          final List listData = response.data['data'] ?? [];
          communityList.assignAll(
            listData.map((e) => CommunityModel.fromJson(e)).toList()
          );
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching community: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await fetchCommunity();
  }

  Future<void> joinCommunity(String? url) async {
    if (url != null && url.isNotEmpty) {
      final uri = Uri.tryParse(url);
      if (uri != null && await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Helpers.showError('Could not launch the link');
      }
    } else {
      Helpers.showError('No link provided');
    }
  }
}
