import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../../config/routes/app_pages.dart';

/// ===================== AUTH MIDDLEWARE =====================
/// Route guard that redirects unauthenticated users to the login screen.
/// Attach to any GetPage that requires authentication.
class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    // Auth check enabled

    final authService = Get.find<AuthService>();
    if (!authService.isAuthenticated) {
      return const RouteSettings(name: AppRoutes.LOGIN);
    }
    return null;
  }
}
