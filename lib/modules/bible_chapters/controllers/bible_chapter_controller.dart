import 'package:get/get.dart';
import 'package:handy/core/services/api_client.dart';
import 'package:handy/core/utils/helpers.dart';
import '../../../config/routes/app_pages.dart';

class BibleChapterController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();

  final bookId = ''.obs;
  final bookName = ''.obs;
  final versionId = 1.obs;

  final isLoading = false.obs;
  final chaptersList = <String>[].obs;
  final selectedChapter = '1'.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      bookId.value = args['bookId'] ?? '';
      bookName.value = args['name'] ?? 'Unknown';
      versionId.value = args['versionId'] ?? 1;
    } else if (args != null && args is String) {
      bookName.value = args;
    }

    if (bookId.value.isNotEmpty) {
      fetchChapters();
    }
  }

  Future<void> refreshData() async {
    if (bookId.value.isNotEmpty) {
      await fetchChapters();
    }
  }

  Future<void> fetchChapters() async {
    isLoading.value = true;
    try {
      final response = await apiClient.getData('/bible/books/${bookId.value}/chapters?version=${versionId.value}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          final List listData = response.data['data'];
          chaptersList.assignAll(listData.map((e) => e['chapter_number'].toString()).toList());
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching chapters: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onChapterSelected(String chapter) {
    selectedChapter.value = chapter;
    Get.toNamed(AppRoutes.BIBLE_VERSES, arguments: {
      'bookId': bookId.value,
      'book': bookName.value,
      'chapter': chapter,
      'versionId': versionId.value,
    });
  }
}
