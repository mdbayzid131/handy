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
  
  // Pagination State
  int currentPage = 1;
  bool hasMore = true;
  final isLoadingMore = false.obs;

  int myCurrentPage = 1;
  bool myHasMore = true;
  final isMyLoadingMore = false.obs;

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

    fetchRequests(isRefresh: true);
    fetchMyRequests(isRefresh: true);

    ever(isPrayerWall, (_) {
      if (isPrayerWall.value && requests.isEmpty) {
        fetchRequests(isRefresh: true);
      } else if (!isPrayerWall.value && myRequests.isEmpty) {
        fetchMyRequests(isRefresh: true);
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
      await fetchRequests(isRefresh: true);
    } else {
      await fetchMyRequests(isRefresh: true);
    }
  }

  void loadMore() {
    if (isPrayerWall.value) {
      fetchRequests();
    } else {
      fetchMyRequests();
    }
  }

  Future<void> fetchRequests({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
    }
    if (!hasMore || isLoadingMore.value) return;

    if (currentPage == 1 && requests.isEmpty) {
      isLoading.value = true;
    } else if (currentPage > 1) {
      isLoadingMore.value = true;
    }

    try {
      final response = await apiClient.getData('${ApiConstants.prayerRequests}?page=$currentPage&limit=10');
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null) {
          final responseData = PrayerWallResponseModel.fromJson(response.data);
          final newItems = responseData.data;
          
          if (isRefresh) {
            requests.assignAll(newItems);
          } else {
            requests.addAll(newItems);
          }
          
          final pagination = responseData.pagination;
          if (pagination != null) {
             if (currentPage >= pagination.totalPage) {
               hasMore = false;
             } else {
               currentPage++;
             }
          } else {
             if (newItems.length < 10) {
               hasMore = false;
             } else {
               currentPage++;
             }
          }
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching prayer requests: $e');
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> fetchMyRequests({bool isRefresh = false}) async {
    if (isRefresh) {
      myCurrentPage = 1;
      myHasMore = true;
    }
    if (!myHasMore || isMyLoadingMore.value) return;

    if (myCurrentPage == 1 && myRequests.isEmpty) {
      isLoading.value = true;
    } else if (myCurrentPage > 1) {
      isMyLoadingMore.value = true;
    }

    try {
      // Note: Assuming myPrayerRequests supports pagination
      final url = ApiConstants.myPrayerRequests.contains('?') 
          ? '${ApiConstants.myPrayerRequests}&page=$myCurrentPage&limit=10' 
          : '${ApiConstants.myPrayerRequests}?page=$myCurrentPage&limit=10';
      final response = await apiClient.getData(url);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null) {
          final responseData = PrayerWallResponseModel.fromJson(response.data);
          final newItems = responseData.data;
          
          if (isRefresh) {
            myRequests.assignAll(newItems);
          } else {
            myRequests.addAll(newItems);
          }
          
          final pagination = responseData.pagination;
          if (pagination != null) {
             if (myCurrentPage >= pagination.totalPage) {
               myHasMore = false;
             } else {
               myCurrentPage++;
             }
          } else {
             if (newItems.length < 10) {
               myHasMore = false;
             } else {
               myCurrentPage++;
             }
          }
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching my prayer requests: $e');
    } finally {
      isLoading.value = false;
      isMyLoadingMore.value = false;
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
        Get.back(); // close bottom sheet FIRST
        Helpers.showSuccess('Prayer request shared successfully', title: 'Success');
        
        requestController.clear();
        isAnonymous.value = false;
        
        // Refresh both lists
        fetchRequests(isRefresh: true);
        fetchMyRequests(isRefresh: true);
      } else {
        String errorMessage = 'Failed to submit request';
        if (response.data != null && response.data is Map && response.data['message'] != null) {
          errorMessage = response.data['message'].toString();
        }
        Helpers.showError(errorMessage, title: 'Error');
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
