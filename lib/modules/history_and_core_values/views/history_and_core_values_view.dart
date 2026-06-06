import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/themes/app_theme.dart';
import '../controllers/history_and_core_values_controller.dart';

class HistoryAndCoreValuesView extends GetView<HistoryAndCoreValuesController> {
  const HistoryAndCoreValuesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: AppTheme.backgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white
                : AppTheme.black,
            size: 24.w,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'History & Core Values',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white
                : AppTheme.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white.withValues(alpha: 0.05)
                : AppTheme.black.withValues(alpha: 0.1),
            height: 1.h,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                context,
                title: 'Our History',
                content:
                    'Founded with a vision to connect people globally, our journey began as a small community initiative. Over the years, we have grown into a platform that empowers individuals through technology and compassion. Our history is a testament to the dedication of our community and the relentless pursuit of our mission.',
              ),
              SizedBox(height: 32.h),
              _buildSection(
                context,
                title: 'Core Values',
                content:
                    '• Integrity\nWe believe in doing the right thing, even when no one is watching.\n\n'
                    '• Compassion\nWe care about the well-being of our community and strive to make a positive impact.\n\n'
                    '• Innovation\nWe continuously seek new ways to improve and provide the best experience.\n\n'
                    '• Excellence\nWe set high standards for ourselves and are committed to achieving them.',
              ),
              SizedBox(height: 32.h),
              _buildSection(
                context,
                title: 'Our Mission',
                content:
                    'To foster a supportive and connected environment where everyone can grow, learn, and thrive together.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white
                : AppTheme.black,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          content,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white.withValues(alpha: 0.8)
                : AppTheme.black.withValues(alpha: 0.8),
            fontSize: 16.sp,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
