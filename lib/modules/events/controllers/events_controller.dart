import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/config/constants/api_constants.dart';
import '../../../core/services/api_client.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/events_model.dart';

class EventsController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();
  final scrollController = ScrollController();

  final selectedCategory = Rxn<EventCategoryModel>(EventCategoryModel(id: 'all', label: 'All'));
  final categories = <EventCategoryModel>[].obs;
  final isCategoriesLoading = true.obs;

  final allEvents = <EventModel>[].obs;
  final isFirstLoad = true.obs;
  final isLoadMore = false.obs;

  int currentPage = 1;
  final int limit = 10;
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
          
          if (!list.any((c) => c.id.toLowerCase() == 'all')) {
            list.insert(0, EventCategoryModel(id: 'all', label: 'All'));
          }

          categories.assignAll(list);
          selectedCategory.value = list.firstWhere(
            (c) => c.id.toLowerCase() == 'all', 
            orElse: () => list.first
          );
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

    if (currentPage == 1 && allEvents.isEmpty) {
      isFirstLoad.value = true;
    }

    try {
      Map<String, dynamic> query = {
        'page': currentPage,
        'limit': limit,
      };
      
      if (selectedCategory.value != null && selectedCategory.value!.id != 'all') {
        query['category'] = selectedCategory.value!.label.toLowerCase();
      }

      final response = await apiClient.getData(ApiConstants.events, query: query);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          final eventsData = EventsResponseModel.fromJson(response.data['data']);
          final list = eventsData.events;
          
          if (currentPage == 1) {
            allEvents.assignAll(list);
          } else {
            allEvents.addAll(list);
          }
          
          if (list.length < limit || allEvents.length >= eventsData.total) {
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
    allEvents.clear();
    fetchEvents(isRefresh: true);
  }
}