import 'package:get/get.dart';
import 'package:handy/modules/community/controllers/community_controller.dart';

class CommunityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityController>(() => CommunityController());
  }
}
