import 'package:get/get.dart';
import '../../../config/routes/app_pages.dart';

class BibleChapterController extends GetxController {
  final bookName = ''.obs;
  final chaptersCount = 0.obs;
  final selectedChapter = 1.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      bookName.value = args['name'] ?? 'Unknown';
      chaptersCount.value = args['chaptersCount'] ?? 0;
    } else if (args != null && args is String) {
      bookName.value = args;
      chaptersCount.value = 50; 
    }
  }

  void onChapterSelected(int chapter) {
    selectedChapter.value = chapter;
    Get.toNamed(AppRoutes.BIBLE_VERSES, arguments: {
      'book': bookName.value,
      'chapter': chapter,
    });
  }
}
