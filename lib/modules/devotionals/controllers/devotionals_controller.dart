import 'package:get/get.dart';
import 'package:handy/core/services/storage_service.dart';

class DevotionalsController extends GetxController {
  final RxSet<int> clickedIndices = <int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _loadClickedIndices();

    ever(clickedIndices, (set) {
      StorageService.setStringList('clickedIndices', set.map((e) => e.toString()).toList());
    });
  }

  Future<void> _loadClickedIndices() async {
    List<String>? storedIndices = await StorageService.getStringList('clickedIndices');
    if (storedIndices != null) {
      clickedIndices.addAll(storedIndices.map((e) => int.parse(e)));
    }
  }
}
