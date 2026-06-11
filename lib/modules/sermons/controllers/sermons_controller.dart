import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/config/constants/api_constants.dart';
import '../../../core/services/api_client.dart';
import '../../../core/services/api_checker.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/sermon_response_model.dart';
import '../../../data/models/sermon_categorys_response_model.dart';

class SermonsController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();
  final scrollController = ScrollController();

  final searchQuery = ''.obs;
  final selectedCategoryId = 'All'.obs;

  final categories = <SermonCategory>[].obs;
  final isCategoriesLoading = true.obs;

  final allSermons = <SermonModel>[].obs;
  final isFirstLoad = true.obs;
  final isLoadMore = false.obs;

  int currentPage = 1;
  final int limit = 10;
  bool hasNextPage = true;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    
    // Server-side search with debounce
    debounce(searchQuery, (_) {
      fetchSermons();
    }, time: const Duration(milliseconds: 500));

    fetchCategories();
    fetchSermons();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> refreshData() async {
    fetchCategories();
    await fetchSermons();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 50) {
      loadMoreSermons();
    }
  }

  List<SermonModel> get filteredSermons {
    // Client-side fallback filter
    return allSermons.where((sermon) {
      final titleMatches =
          sermon.title?.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ) ??
          false;
      final speakerMatches =
          sermon.speaker?.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ) ??
          false;
      final matchesSearch = titleMatches || speakerMatches;

      final matchesCategory =
          selectedCategoryId.value == 'All' ||
          (sermon.category?.id == selectedCategoryId.value);
          
      return matchesSearch && matchesCategory;
    }).toList();
  }

  void selectCategory(String categoryId) {
    selectedCategoryId.value = categoryId;
    fetchSermons();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  Future<void> fetchCategories() async {
    isCategoriesLoading.value = true;
    try {
      final response = await apiClient.getData(ApiConstants.sermonCategories);
      ApiChecker.checkGetApi(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = SermonCategoryResponse.fromJson(response.data);
        if (res.success == true && res.data != null) {
          final List<SermonCategory> catList = [
            SermonCategory(name: 'All', id: 'All'), // Insert All
            ...res.data!
          ];
          categories.assignAll(catList);
        }
      }
    } catch (e, s) {
      Helpers.showDebugLog('Error fetching categories: $e\n$s');
      categories.assignAll([SermonCategory(name: 'All', id: 'All')]);
    } finally {
      isCategoriesLoading.value = false;
    }
  }

  Future<void> fetchSermons() async {
    isFirstLoad.value = true;
    currentPage = 1;
    hasNextPage = true;
    allSermons.clear();

    try {
      final Map<String, dynamic> query = {
        'page': currentPage,
        'limit': limit,
      };

      if (searchQuery.value.isNotEmpty) {
        query['searchTerm'] = searchQuery.value;
      }
      
      if (selectedCategoryId.value != 'All') {
        query['category'] = selectedCategoryId.value;
      }

      final response = await apiClient.getData(
        ApiConstants.sermons,
        query: query,
      );

      ApiChecker.checkGetApi(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseModel = SermonListResponseModel.fromJson(response.data);
        if (responseModel.success == true && responseModel.data != null) {
          allSermons.assignAll(responseModel.data!.data ?? []);
          hasNextPage = responseModel.data!.pagination?.hasNextPage ?? false;
        }
      }
    } catch (e, s) {
      Helpers.showDebugLog('Error fetching sermons: $e\n$s');
    } finally {
      isFirstLoad.value = false;
    }
  }

  Future<void> loadMoreSermons() async {
    if (isLoadMore.value || !hasNextPage) return;

    isLoadMore.value = true;
    currentPage++;

    try {
      final Map<String, dynamic> query = {
        'page': currentPage,
        'limit': limit,
      };

      if (searchQuery.value.isNotEmpty) {
        query['searchTerm'] = searchQuery.value;
      }
      
      if (selectedCategoryId.value != 'All') {
        query['category'] = selectedCategoryId.value;
      }

      final response = await apiClient.getData(
        ApiConstants.sermons,
        query: query,
      );

      ApiChecker.checkGetApi(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseModel = SermonListResponseModel.fromJson(response.data);
        if (responseModel.success == true && responseModel.data != null) {
          allSermons.addAll(responseModel.data!.data ?? []);
          hasNextPage = responseModel.data!.pagination?.hasNextPage ?? false;
        }
      } else {
        currentPage--;
      }
    } catch (e, s) {
      Helpers.showDebugLog('Error fetching more sermons: $e\n$s');
      currentPage--;
    } finally {
      isLoadMore.value = false;
    }
  }
}
