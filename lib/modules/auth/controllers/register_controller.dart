import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/routes/app_pages.dart';
import '../../../core/services/api_checker.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/utils/logger.dart';
import '../../../data/models/user_model.dart';

class RegisterController extends GetxController {
  final AuthService _authService = Get.find();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;
    
    if (passwordController.text != confirmPasswordController.text) {
      Helpers.showCustomSnackBar('Passwords do not match');
      return;
    }

    try {
      isLoading.value = true;

      final response = await _authService.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null && response.data['data'] != null) {
          final user = UserModel.fromJson(response.data['data']);
          AppLogger.info('User created successfully: ${user.name}');
        }
        final message = response.data?['message'] ?? 'Registration successful';
        Helpers.showCustomSnackBar(message);
        Get.offAllNamed(AppRoutes.LOGIN);
      } else {
        ApiChecker.checkWriteApi(response);
      }
    } on DioException catch (e) {
      AppLogger.error(e);
      if (e.response != null) {
        ApiChecker.checkWriteApi(e.response!);
      } else {
        Helpers.showError(e.message ?? 'Unknown error occurred');
      }
    } catch (e) {
      AppLogger.warning('Registration Error: $e');
      Helpers.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void goToLogin() {
    Get.back();
  }
}
