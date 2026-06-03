import 'package:get/get.dart';
import 'package:handy/modules/bible_chapters/controllers/bible_chapter_controller.dart';

class BibleChapterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BibleChapterController>(() => BibleChapterController());
  }
}
