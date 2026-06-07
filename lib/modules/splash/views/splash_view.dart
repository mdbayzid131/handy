import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:handy/config/constants/image_paths.dart';
import 'package:handy/config/themes/app_theme.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            CircleAvatar(
              radius: 50.r,
              backgroundColor: AppTheme.backgroundColor,
              child: ClipOval(
                child: Image.asset(
                  ImagePaths.appLogo,
                  fit: BoxFit.cover,
                  width: 200.h,
                  height: 200.h,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
