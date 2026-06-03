import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/history_and_core_values_controller.dart';

class HistoryAndCoreValuesView extends GetView<HistoryAndCoreValuesController> {
  const HistoryAndCoreValuesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0F172A),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.w),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'History & Core Values',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(color: Colors.white.withOpacity(0.05), height: 1.h),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                title: 'Our History',
                content: 'Founded with a vision to connect people globally, our journey began as a small community initiative. Over the years, we have grown into a platform that empowers individuals through technology and compassion. Our history is a testament to the dedication of our community and the relentless pursuit of our mission.',
              ),
              SizedBox(height: 32.h),
              _buildSection(
                title: 'Core Values',
                content: '• Integrity\nWe believe in doing the right thing, even when no one is watching.\n\n'
                    '• Compassion\nWe care about the well-being of our community and strive to make a positive impact.\n\n'
                    '• Innovation\nWe continuously seek new ways to improve and provide the best experience.\n\n'
                    '• Excellence\nWe set high standards for ourselves and are committed to achieving them.',
              ),
              SizedBox(height: 32.h),
              _buildSection(
                title: 'Our Mission',
                content: 'To foster a supportive and connected environment where everyone can grow, learn, and thrive together.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          content,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 16.sp,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
