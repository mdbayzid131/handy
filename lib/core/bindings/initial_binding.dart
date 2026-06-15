import 'package:get/get.dart';
import '../../data/repositories/user_repository.dart';
import '../controllers/internet_controller.dart';
import '../services/api_client.dart';
import '../services/auth_service.dart';
import '../services/connectivity_service.dart';
import '../services/storage_service.dart';

/// ===================== INITIAL BINDING =====================
/// Registers all core services and controllers at app startup.
/// Order matters — services with dependencies must come after their dependencies.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // ─── Core Services (order matters) ───
    Get.put(StorageService(), permanent: true);
    Get.put(InternetController(), permanent: true);
    Get.put(ApiClient(), permanent: true);
    Get.put(AuthService(), permanent: true);

    // ─── Repositories ───
    Get.put(UserRepository(), permanent: true);

    // ─── Initialize Connectivity Listener ───
    ConnectivityService.init();
  }
}
