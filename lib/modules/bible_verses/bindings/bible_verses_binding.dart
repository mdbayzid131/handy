import 'package:get/get.dart';
import 'package:handy/modules/bible_verses/controllers/bible_verses_controller.dart';

class BibleVersesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BibleVersesController>(() => BibleVersesController());
  }
}
