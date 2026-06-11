import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/routes/app_pages.dart';
import '../../../core/services/api_checker.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/utils/logger.dart';
import '../../../data/models/user_model.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final response = await _authService.login(
        email: emailController.text,
        password: passwordController.text,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null && response.data['data'] != null) {
          final user = UserModel.fromJson(response.data['data']);
          _authService.currentUser.value = user;
        }
        await _authService.handleAuthResponse(response);

        Helpers.showCustomSnackBar(
          response.data?['message'] ?? 'Login successful',
          type: SnackBarType.success,
        );
        Get.offAllNamed(AppRoutes.BOTTOM_NAV_BAR);
      } else {
        ApiChecker.checkWriteApi(response);
      }
    } on DioException catch (e) {
      AppLogger.error(e);
      if (e.response != null) {
        ApiChecker.checkWriteApi(e.response!);
      } else {
        Helpers.showError(e.message ?? 'Network error occurred');
      }
    } catch (e) {
      AppLogger.warning('Login Error: $e');
      Helpers.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void goToRegister() {
    Get.toNamed(AppRoutes.REGISTER);
  }

  void goToForgotPassword() {
    Get.toNamed(AppRoutes.FORGOT_PASSWORD);
  }

  void continueAsGuest() {
    Get.offAllNamed(AppRoutes.BOTTOM_NAV_BAR);
  }
}
