import 'package:get/get.dart';

/// ===================== INTERNET CONTROLLER =====================
/// Reactive controller that tracks internet connectivity state.
/// Used by ConnectivityService, ApiClient, and SafeNetworkImage.
class InternetController extends GetxController {
  final hasInternet = true.obs;
  final isShowingNoInternet = false.obs;

  void setOffline() {
    hasInternet.value = false;
    isShowingNoInternet.value = true;
  }

  void setOnline() {
    hasInternet.value = true;
    isShowingNoInternet.value = false;
  }

  /// Toggle connectivity (useful for testing)
  void toggle() {
    hasInternet.value ? setOffline() : setOnline();
  }
}
