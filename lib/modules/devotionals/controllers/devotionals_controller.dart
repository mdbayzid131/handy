import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:handy/core/services/api_client.dart';
import 'package:handy/core/utils/helpers.dart';
import 'package:handy/config/constants/api_constants.dart';
import 'package:handy/core/services/auth_service.dart';
import 'package:handy/data/models/devotional_model.dart';

class DevotionalsController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();

  final isLoading = false.obs;
  final isLoadMore = false.obs;
  final devotionalsList = <DevotionalModel>[].obs;

  int currentPage = 1;
  int totalPages = 1;
  final int limit = 10;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    if (Get.find<AuthService>().isLoggedIn.value) {
      fetchDevotionals();
    } else {
      isLoading.value = false;
    }
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 50) {
      if (!isLoading.value && !isLoadMore.value && currentPage < totalPages) {
        loadMoreDevotionals();
      }
    }
  }

  Future<void> fetchDevotionals({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    }

    if (currentPage == 1) {
      isLoading.value = true;
    } else {
      isLoadMore.value = true;
    }

    try {
      final response = await apiClient.getData('${ApiConstants.devotionalsList}?page=$currentPage&limit=$limit');
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          final responseData = DevotionalsResponseModel.fromJson(response.data['data']);
          final items = responseData.devotionals;

          if (currentPage == 1) {
            devotionalsList.assignAll(items);
          } else {
            devotionalsList.addAll(items);
          }

          final total = responseData.total;
          totalPages = (total / limit).ceil();
          if (totalPages == 0) totalPages = 1;
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching devotionals: $e');
    } finally {
      isLoading.value = false;
      isLoadMore.value = false;
    }
  }

  Future<void> loadMoreDevotionals() async {
    currentPage++;
    await fetchDevotionals();
  }

  Future<void> refreshData() async {
    await fetchDevotionals(isRefresh: true);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
