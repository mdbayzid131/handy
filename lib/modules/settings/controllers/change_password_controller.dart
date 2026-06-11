import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/api_checker.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/utils/logger.dart';

class ChangePasswordController extends GetxController {
  final AuthService _authService = Get.find();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isOldPasswordVisible = false.obs;
  final isNewPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void toggleOldPasswordVisibility() {
    isOldPasswordVisible.value = !isOldPasswordVisible.value;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'New password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (value == oldPasswordController.text) {
      return 'New password must be different from old password';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final response = await _authService.changePassword(
        currentPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _clearForm();
        Get.back(); // Close bottom sheet or screen
        Helpers.showCustomSnackBar(
          response.data?['message'] ?? 'Password changed successfully',
          type: SnackBarType.success,
        );
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
      AppLogger.warning('Change Password Error: $e');
      Helpers.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _clearForm() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }
}
