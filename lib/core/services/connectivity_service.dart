import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '../controllers/internet_controller.dart';

/// ===================== CONNECTIVITY SERVICE =====================
/// Listens to network connectivity changes and updates InternetController.
/// Call `ConnectivityService.init()` once during app startup.
class ConnectivityService {
  ConnectivityService._();

  static void init() {
    final internet = Get.find<InternetController>();

    Connectivity().onConnectivityChanged.listen((results) {
      // connectivity_plus returns List<ConnectivityResult> in newer versions
      if (results is List) {
        final hasConnection = (results as List).any(
          (r) => r != ConnectivityResult.none,
        );
        hasConnection ? internet.setOnline() : internet.setOffline();
      } else {
        // Fallback for older versions
        final result = results;
        result == ConnectivityResult.none
            ? internet.setOffline()
            : internet.setOnline();
      }
    });
  }
}
