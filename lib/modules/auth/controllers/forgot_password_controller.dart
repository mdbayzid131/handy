import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/routes/app_pages.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/utils/helpers.dart';

class ForgotPasswordController extends GetxController {
  final AuthService _authService = Get.find();

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> sendResetLink() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final response = await _authService.forgotPassword(emailController.text);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final message = response.data['message'] ?? 'Please check your email for the OTP.';
        Helpers.showCustomSnackBar(message);
        Get.toNamed(AppRoutes.OTP_VERIFICATION, arguments: emailController.text);
      } else {
        Helpers.showCustomSnackBar(response.data['message'] ?? 'Something went wrong');
      }
    } catch (e) { 
      Helpers.showCustomSnackBar(
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goBack() {
    Get.back();
  }
}
