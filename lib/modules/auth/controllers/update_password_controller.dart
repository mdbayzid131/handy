import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/services/auth_service.dart';
import '../../../config/routes/app_pages.dart';

class UpdatePasswordController extends GetxController {
  final AuthService _authService = Get.find();
  final formKey = GlobalKey<FormState>();

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isNewPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  final isLoading = false.obs;

  String token = '';

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map) {
      token = args['token'] ?? '';
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> updatePassword() async {
    if (!formKey.currentState!.validate()) return;
    
    if (newPasswordController.text != confirmPasswordController.text) {
      Helpers.showCustomSnackBar('Passwords do not match');
      return;
    }

    try {
      isLoading.value = true;
      final response = await _authService.resetPassword(
        token: token,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final message = response.data['message'] ?? 'Your password has been successfully reset.';
        Helpers.showCustomSnackBar(
          message,
          type: SnackBarType.success,
        );
        Get.offAllNamed(AppRoutes.LOGIN);
      } else {
        Helpers.showCustomSnackBar(response.data['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      Helpers.showCustomSnackBar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
