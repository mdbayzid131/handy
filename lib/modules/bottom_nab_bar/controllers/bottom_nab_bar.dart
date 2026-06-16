import 'package:get/get.dart';
import '../../../config/routes/app_pages.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/utils/helpers.dart';

import '../../home/controllers/home_controller.dart';
import '../../sermons/controllers/sermons_controller.dart';
import '../../give/controllers/give_controller.dart';
import '../../events/controllers/events_controller.dart';
import '../../more/controllers/more_controller.dart';

class BottomNavBarController extends GetxController {
  final AuthService _authService = Get.find();

  final currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
    
    // Auto-fetch data silently on tab switch to ensure fresh data
    switch (index) {
      case 0:
        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().refreshHome();
        }
        break;
      case 1:
        if (Get.isRegistered<SermonsController>()) {
          Get.find<SermonsController>().refreshData();
        }
        break;
      case 2:
        if (Get.isRegistered<GiveController>()) {
          Get.find<GiveController>().fetchFunds();
        }
        break;
      case 3:
        if (Get.isRegistered<EventsController>()) {
          Get.find<EventsController>().refreshEvents();
        }
        break;
      case 4:
        if (Get.isRegistered<MoreController>()) {
          Get.find<MoreController>().refreshData();
        }
        break;
    }
  }

  void goToProfile() {
    if (_authService.isLoggedIn.value) {
      Get.toNamed(AppRoutes.PROFILE);
    } else {
      Get.toNamed(AppRoutes.LOGIN);
    }
  }

  Future<void> logout() async {
    Helpers.showLoadingDialog();

    await _authService.logout();

    Helpers.hideLoadingDialog();
    Helpers.showCustomSnackBar('Logged out successfully');

    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
