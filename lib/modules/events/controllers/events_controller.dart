import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/config/constants/api_constants.dart';
import '../../../core/services/api_client.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/events_model.dart';

class EventsController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();
  final scrollController = ScrollController();

  final selectedCategory = Rxn<EventCategoryModel>();
  final categories = <EventCategoryModel>[].obs;
  final isCategoriesLoading = true.obs;

  final allEvents = <EventModel>[].obs;
  final isFirstLoad = true.obs;
  final isLoadMore = false.obs;

  int currentPage = 1;
  final int limit = 20;
  bool hasNextPage = true;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    
    fetchCategories();
    fetchEvents();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      loadMoreEvents();
    }
  }

  Future<void> fetchCategories() async {
    isCategoriesLoading.value = true;
    try {
      final response = await apiClient.getData(ApiConstants.eventsCategories);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          final list = (response.data['data'] as List)
              .map((x) => EventCategoryModel.fromJson(x))
              .toList();
          categories.assignAll(list);
          if (list.isNotEmpty) {
            selectedCategory.value = list.firstWhere((c) => c.id == 'all', orElse: () => list.first);
          }
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching event categories: $e');
    } finally {
      isCategoriesLoading.value = false;
    }
  }

  Future<void> fetchEvents({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      hasNextPage = true;
    }

    if (!hasNextPage) return;

    if (currentPage == 1) {
      isFirstLoad.value = true;
    }

    try {
      String url = '${ApiConstants.events}?page=$currentPage&limit=$limit';
      if (selectedCategory.value != null && selectedCategory.value!.id != 'all') {
        url += '&categoryId=${selectedCategory.value!.id}';
      }

      final response = await apiClient.getData(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null && response.data['data']['events'] != null) {
          final list = (response.data['data']['events'] as List)
              .map((x) => EventModel.fromJson(x))
              .toList();
          
          if (currentPage == 1) {
            allEvents.assignAll(list);
          } else {
            allEvents.addAll(list);
          }
          
          if (list.length < limit) {
            hasNextPage = false;
          }
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching events: $e');
    } finally {
      isFirstLoad.value = false;
    }
  }

  Future<void> loadMoreEvents() async {
    if (isLoadMore.value || !hasNextPage) return;
    
    isLoadMore.value = true;
    currentPage++;
    try {
      await fetchEvents();
    } catch (e) {
      Helpers.showDebugLog('Error fetching more events: $e');
      currentPage--;
    } finally {
      isLoadMore.value = false;
    }
  }

  Future<void> refreshEvents() async {
    await fetchEvents(isRefresh: true);
  }

  void selectCategory(EventCategoryModel category) {
    selectedCategory.value = category;
    fetchEvents(isRefresh: true);
  }
}