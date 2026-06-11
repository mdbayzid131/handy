import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/register_controller.dart';
import 'package:handy/config/themes/app_theme.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

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
                          Icons.person,
                          size: 60.w,
                          color: AppTheme.warningColor,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Create Account',
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
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20.h),

                      // Name Field
                      CustomTextField(
                        controller: controller.nameController,
                        hintText: 'Full Name',
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: AppTheme.white.withValues(alpha: 0.5),
                        ),
                        validator: (value) => Validators.name(value),
                      ),
                      SizedBox(height: 16.h),

                      // Email Field
                      CustomTextField(
                        controller: controller.emailController,
                        hintText: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: AppTheme.white.withValues(alpha: 0.5),
                        ),
                        validator: Validators.email,
                      ),
                      SizedBox(height: 16.h),

                      // Password Field
                      Obx(
                        () => CustomTextField(
                          controller: controller.passwordController,
                          hintText: 'Password',
                          obscureText: !controller.isPasswordVisible.value,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: AppTheme.white.withValues(alpha: 0.5),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppTheme.white.withValues(alpha: 0.5),
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                          validator: Validators.password,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Confirm Password Field
                      Obx(
                        () => CustomTextField(
                          controller: controller.confirmPasswordController,
                          hintText: 'Confirm Password',
                          obscureText:
                              !controller.isConfirmPasswordVisible.value,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: AppTheme.white.withValues(alpha: 0.5),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isConfirmPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppTheme.white.withValues(alpha: 0.5),
                            ),
                            onPressed:
                                controller.toggleConfirmPasswordVisibility,
                          ),
                          validator: (value) {
                            // if (value != controller.passwordController.text) {
                            //   return 'Passwords do not match';
                            // }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 40.h),

                      // Register Button
                      Obx(
                        () => CustomButton(
                          text: 'Sign Up',
                          backgroundColor: AppTheme.accentBlue,
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.register();
                            }
                          },
                          isLoading: controller.isLoading.value,
                        ),
                      ),
                      SizedBox(height: 32.h),

                      // Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppTheme.white.withValues(alpha: 0.6)
                                  : AppTheme.black.withValues(alpha: 0.6),
                              fontSize: 14.sp,
                            ),
                          ),
                          GestureDetector(
                            onTap: Get.back,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: AppTheme.warningColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
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
