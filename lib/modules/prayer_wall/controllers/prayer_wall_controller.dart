import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/core/services/api_client.dart';
import 'package:handy/core/services/auth_service.dart';
import 'package:handy/core/utils/helpers.dart';
import 'package:handy/config/constants/api_constants.dart';
import '../../../data/models/prayer_wall_model.dart';

class PrayerWallController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();
  final AuthService authService = Get.find<AuthService>();

  final requests = <PrayerWallModel>[].obs;
  final myRequests = <PrayerWallModel>[].obs;
  
  final isLoading = false.obs;
  final isSubmitting = false.obs;

  final isAnonymous = false.obs;
  final isPrayerWall = true.obs;

  final nameController = TextEditingController();
  final requestController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final user = authService.currentUser.value;
    if (user != null) {
      nameController.text = user.name ?? '';
    }

    fetchRequests();
    fetchMyRequests();

    ever(isPrayerWall, (_) {
      if (isPrayerWall.value && requests.isEmpty) {
        fetchRequests();
      } else if (!isPrayerWall.value && myRequests.isEmpty) {
        fetchMyRequests();
      }
    });
  }

  @override
  void onClose() {
    nameController.dispose();
    requestController.dispose();
    super.onClose();
  }

  Future<void> refreshData() async {
    if (isPrayerWall.value) {
      await fetchRequests();
    } else {
      await fetchMyRequests();
    }
  }

  Future<void> fetchRequests() async {
    isLoading.value = true;
    try {
      final response = await apiClient.getData('${ApiConstants.prayerRequests}?page=1&limit=50');
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          final List listData = response.data['data'];
          requests.assignAll(listData.map((e) => PrayerWallModel.fromJson(e)).toList());
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching prayer requests: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMyRequests() async {
    isLoading.value = true;
    try {
      final response = await apiClient.getData(ApiConstants.myPrayerRequests);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          final List listData = response.data['data'];
          myRequests.assignAll(listData.map((e) => PrayerWallModel.fromJson(e)).toList());
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching my prayer requests: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitRequest() async {
    if (requestController.text.trim().isEmpty) {
      Helpers.showError('Prayer request cannot be empty', title: 'Error');
      return;
    }
    
    isSubmitting.value = true;
    try {
      final data = {
        "content": requestController.text.trim(),
        "author_name": isAnonymous.value ? "Anonymous" : nameController.text.trim(),
        "is_anonymous": isAnonymous.value
      };
      final response = await apiClient.postData(ApiConstants.prayerRequests, data);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        Helpers.showSuccess('Prayer request shared successfully', title: 'Success');
        requestController.clear();
        isAnonymous.value = false;
        Get.back(); // close bottom sheet
        
        // Refresh both lists
        fetchRequests();
        fetchMyRequests();
      }
    } catch (e) {
      Helpers.showDebugLog('Error submitting prayer request: $e');
      Helpers.showError('Failed to submit request', title: 'Error');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> prayForRequest(String id) async {
    try {
      final response = await apiClient.postData(ApiConstants.prayForRequest(id), {});
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
           final updatedRequest = PrayerWallModel.fromJson(response.data['data']);
           final index = requests.indexWhere((r) => r.id == id);
           if (index != -1) {
             requests[index] = updatedRequest;
           }
           final myIndex = myRequests.indexWhere((r) => r.id == id);
           if (myIndex != -1) {
             myRequests[myIndex] = updatedRequest;
           }
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error praying for request: $e');
      Helpers.showError('Failed to record prayer', title: 'Error');
    }
  }
}
