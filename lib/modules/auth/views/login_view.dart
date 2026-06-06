import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/login_controller.dart';
import 'package:handy/config/themes/app_theme.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
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
                          Icons.lock_outline,
                          size: 70.w,
                          color: AppTheme.warningColor,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Sign in to continue',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 16.sp,
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
                      // Email Field
                      CustomTextField(
                        controller: controller.emailController,
                        hintText: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                        validator: Validators.email,
                      ),
                      SizedBox(height: 20.h),

                      // Password Field
                      Obx(
                        () => CustomTextField(
                          controller: controller.passwordController,
                          hintText: 'Password',
                          obscureText: !controller.isPasswordVisible.value,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                          validator: Validators.password,
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: controller.goToForgotPassword,
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.warningColor,
                          ),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32.h),

                      // Login Button
                      Obx(
                        () => CustomButton(
                          text: 'Login',
                          backgroundColor: AppTheme.accentBlue,
                          onPressed: () {
                            // if (controller.formKey.currentState!.validate()) {
                            //   Get.toNamed(AppRoutes.BOTTOM_NAV_BAR);
                            // }
                          },
                          isLoading: controller.isLoading.value,
                        ),
                      ),
                      SizedBox(height: 32.h),

                      // Register Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white.withValues(alpha: 0.6)
                                  : Colors.black.withValues(alpha: 0.6),
                              fontSize: 14.sp,
                            ),
                          ),
                          GestureDetector(
                            onTap: controller.goToRegister,
                            child: Text(
                              'Register',
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
