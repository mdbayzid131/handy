import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  const UpdatePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: Colors.white),
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
                    colors: [Color(0xFF2844B4), Color(0xFF0A123D)],
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
                          Icons.password_outlined,
                          size: 70.w,
                          color: const Color(0xFFFFC107),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Update Password',
                          style: TextStyle(
                            color: Colors.white,
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
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10.h),

                      // Current Password Field
                      Obx(
                        () => CustomTextField(
                          controller: controller.currentPasswordController,
                          label: 'Current Password',
                          hintText: 'Enter your current password',
                          obscureText:
                              !controller.isCurrentPasswordVisible.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isCurrentPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                            onPressed:
                                controller.toggleCurrentPasswordVisibility,
                          ),
                          validator: (value) => Validators.required(
                            value,
                            message: 'Please enter your current password',
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // New Password Field
                      Obx(
                        () => CustomTextField(
                          controller: controller.newPasswordController,
                          label: 'New Password',
                          hintText: 'Enter your new password',
                          obscureText: !controller.isNewPasswordVisible.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isNewPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                            onPressed: controller.toggleNewPasswordVisibility,
                          ),
                          validator: (value) => Validators.password(value),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Confirm New Password Field
                      Obx(
                        () => CustomTextField(
                          controller: controller.confirmPasswordController,
                          label: 'Confirm New Password',
                          hintText: 'Confirm your new password',
                          obscureText:
                              !controller.isConfirmPasswordVisible.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isConfirmPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                            onPressed:
                                controller.toggleConfirmPasswordVisibility,
                          ),
                          validator: (value) => Validators.confirmPassword(
                            value,
                            controller.newPasswordController.text,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),

                      // Update Password Button
                      Obx(
                        () => CustomButton(
                          text: 'Update Password',
                          backgroundColor: const Color(0xFF3B68E7),
                          onPressed: () {
                            controller.updatePassword();
                          },
                          isLoading: controller.isLoading.value,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
