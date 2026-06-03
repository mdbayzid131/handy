import 'package:get/get.dart';
import 'package:handy/modules/history_and_core_values/controllers/history_and_core_values_controller.dart';

class HistoryAndCoreValuesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryAndCoreValuesController>(
      () => HistoryAndCoreValuesController(),
    );
  }
}
