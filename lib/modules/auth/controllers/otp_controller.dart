import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/utils/helpers.dart';
import 'package:handy/config/routes/app_pages.dart';

class OtpController extends GetxController {
  final AuthService _authService = Get.find();
  final pinController = TextEditingController();

  String email = '';
  bool isForgotPassword = true;

  final isLoading = false.obs;

  // Timer related
  final RxInt resendTimer = 0.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is String) {
      email = args;
    } else if (args is Map) {
      email = args['email'] ?? '';
      isForgotPassword = args['isForgotPassword'] ?? true;
    }
    startTimer();
  }

  void startTimer() {
    resendTimer.value = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> verifyOtp() async {
    final otp = pinController.text;
    if (otp.length != 4) {
      Helpers.showCustomSnackBar('Please enter a valid 4-digit OTP');
      return;
    }

    try {
      isLoading.value = true;
      final response = await _authService.verifyOtp(
        email: email,
        otp: int.parse(otp),
        isForgotPassword: isForgotPassword,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final message = response.data['message'] ?? 'Verification Successful';
        final token = response.data['data'];
        Helpers.showCustomSnackBar(message);

        if (isForgotPassword) {
          Get.toNamed(
            AppRoutes.UPDATE_PASSWORD,
            arguments: {'email': email, 'token': token},
          );
        } else {
          Get.offAllNamed(AppRoutes.BOTTOM_NAV_BAR);
        }
      } else {
        Helpers.showCustomSnackBar(response.data['message'] ?? 'Invalid OTP');
      }
    } catch (e) {
      Helpers.showCustomSnackBar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    if (resendTimer.value > 0) return;

    try {
      if (isForgotPassword) {
        // For forgot password, resending means calling the forgot password API again
        await _authService.forgotPassword(email);
      } else {
        // For signup verification, call resend verification email
        await _authService.resendOtp(email);
      }
      Helpers.showCustomSnackBar(
        'OTP has been resent to your email.',
        type: SnackBarType.success,
      );
      startTimer();
    } catch (e) {
      Helpers.showCustomSnackBar(e.toString());
    }
  }
}
