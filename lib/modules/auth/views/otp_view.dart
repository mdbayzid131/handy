import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_button.dart';
import 'package:handy/config/themes/app_theme.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: AppTheme.white),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Graphic
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primaryLighter, AppTheme.primaryDarker],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.security,
                          size: 70.w,
                          color: AppTheme.warningColor,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Enter OTP',
                          style: TextStyle(
                            color: AppTheme.white,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),

              // Form Section
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      'Please enter the 4-digit code sent to your email address.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.white.withValues(alpha: 0.7)
                            : AppTheme.black.withValues(alpha: 0.7),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 40.h),

                    // OTP Input Fields
                    Center(
                      child: Pinput(
                        controller: controller.pinController,
                        length: 4,
                        defaultPinTheme: PinTheme(
                          width: 64.w,
                          height: 68.h,
                          textStyle: TextStyle(
                            fontSize: 24.sp,
                            color: AppTheme.white,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E2336),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: AppTheme.white.withValues(alpha: 0.05),
                              width: 1,
                            ),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: 64.w,
                          height: 68.h,
                          textStyle: TextStyle(
                            fontSize: 24.sp,
                            color: AppTheme.white,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E2336),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: AppTheme.accentBlue,
                              width: 1.5,
                            ),
                          ),
                        ),
                        submittedPinTheme: PinTheme(
                          width: 64.w,
                          height: 68.h,
                          textStyle: TextStyle(
                            fontSize: 24.sp,
                            color: AppTheme.white,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E2336),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: const Color(
                                0xFF3B68E7,
                              ).withValues(alpha: 0.5),
                              width: 1,
                            ),
                          ),
                        ),
                        showCursor: true,
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 16.h),
                              width: 22.w,
                              height: 2,
                              color: AppTheme.accentBlue,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),

                    // Verify Button
                    Obx(
                      () => CustomButton(
                        text: 'Verify Code',
                        backgroundColor: AppTheme.accentBlue,
                        onPressed: controller.verifyOtp,
                        isLoading: controller.isLoading.value,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Resend Code
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive code? ",
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppTheme.white.withValues(alpha: 0.6)
                                : AppTheme.black.withValues(alpha: 0.6),
                            fontSize: 14.sp,
                          ),
                        ),
                        Obx(
                          () => GestureDetector(
                            onTap: controller.resendTimer.value == 0
                                ? controller.resendOtp
                                : null,
                            child: Text(
                              controller.resendTimer.value > 0
                                  ? 'Resend in ${controller.resendTimer.value}s'
                                  : 'Resend',
                              style: TextStyle(
                                color: controller.resendTimer.value > 0
                                    ? AppTheme.white.withValues(alpha: 0.5)
                                    : AppTheme.warningColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
