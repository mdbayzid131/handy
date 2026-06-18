import 'package:get/get.dart';
import 'package:handy/core/services/api_client.dart';
import 'package:handy/core/utils/helpers.dart';
import '../../../data/models/bible_model.dart';

class BibleVersesController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();

  final bookId = ''.obs;
  final bookName = ''.obs;
  final versionId = 1.obs;
  final chapter = 1.obs;
  final maxChapters = 50.obs; // Hardcoded dummy for next/prev logic limit

  final isLoading = false.obs;
  final verses = <BibleVerseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      bookId.value = args['bookId'] ?? '';
      bookName.value = args['book'] ?? 'Genesis';
      versionId.value = args['versionId'] ?? 1;
      
      final ch = args['chapter'];
      if (ch != null) {
        chapter.value = int.tryParse(ch.toString()) ?? 1;
      }
      
      final max = args['maxChapters'];
      if (max != null) {
        maxChapters.value = int.tryParse(max.toString()) ?? 50;
      }
    }
    
    if (bookId.value.isNotEmpty) {
      fetchVerses();
    }
  }

  Future<void> refreshData() async {
    if (bookId.value.isNotEmpty) {
      await fetchVerses();
    }
  }

  Future<void> fetchVerses() async {
    isLoading.value = true;
    try {
      final response = await apiClient.getData('/bible/books/${bookId.value}/chapters/${chapter.value}?version=${versionId.value}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null && response.data['data']['verses'] != null) {
          final List listData = response.data['data']['verses'];
          verses.assignAll(listData.map((e) => BibleVerseModel.fromJson(e)).toList());
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching verses: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void nextChapter() {
    if (chapter.value < maxChapters.value) {
      chapter.value++;
      fetchVerses();
    }
  }

  void previousChapter() {
    if (chapter.value > 1) {
      chapter.value--;
      fetchVerses();
    }
  }
}
