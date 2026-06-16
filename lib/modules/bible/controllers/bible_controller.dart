import 'package:get/get.dart';
import 'package:handy/core/services/api_client.dart';
import 'package:handy/core/utils/helpers.dart';
import 'package:handy/config/constants/api_constants.dart';
import '../../../data/models/bible_model.dart';

class BibleController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();

  final searchQuery = ''.obs;
  final selectedVersionKey = 'KJV'.obs;
  
  final isLoading = false.obs;
  final versions = <BibleVersionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchVersions();
  }

  Future<void> refreshData() async {
    await fetchVersions();
  }

  Future<void> fetchVersions() async {
    isLoading.value = true;
    try {
      final response = await apiClient.getData(ApiConstants.bibleVersions);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          final List listData = response.data['data'];
          versions.assignAll(listData.map((e) => BibleVersionModel.fromJson(e)).toList());
          
          if (versions.isNotEmpty && !versions.any((v) => v.abbreviation == selectedVersionKey.value)) {
            selectedVersionKey.value = versions.first.abbreviation ?? 'KJV';
          }

          // Fetch books using the active version ID
          final selectedVersion = versions.firstWhereOrNull((v) => v.abbreviation == selectedVersionKey.value);
          if (selectedVersion != null && selectedVersion.id != null) {
            await fetchBooks(selectedVersion.id!);
          } else {
            await fetchBooks(1); // default to KJV
          }
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching bible versions: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchBooks(int versionId) async {
    isLoading.value = true;
    try {
      final response = await apiClient.getData('${ApiConstants.bibleBooks}?version=$versionId');
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          final List listData = response.data['data'];
          booksList.assignAll(listData.map((e) => BibleBook.fromJson(e)).toList());
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching bible books: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void updateVersion(String versionKey) {
    selectedVersionKey.value = versionKey;
    final selectedVersion = versions.firstWhereOrNull((v) => v.abbreviation == versionKey);
    if (selectedVersion != null && selectedVersion.id != null) {
      fetchBooks(selectedVersion.id!);
    }
  }

  final booksList = <BibleBook>[].obs;

  List<BibleBook> get filteredBooks {
    if (searchQuery.value.isEmpty) {
      return booksList.toList();
    }
    return booksList.where((book) => (book.name ?? '').toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
  }
}
