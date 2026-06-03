import 'package:get/get.dart';

class NewsController extends GetxController {
  final RxInt expandedIndex = (-1).obs;

  void toggleExpanded(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }
}