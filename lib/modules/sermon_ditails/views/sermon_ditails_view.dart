import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/sermon_ditails_contoller.dart';
import 'package:handy/config/themes/app_theme.dart';

class SermonDitailsView extends GetView<SermonDitailsController> {
  const SermonDitailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final sermon = controller.sermon;

    return Container(
      color: Colors.black,
      child: Scaffold(
        appBar: AppBar(
        scrolledUnderElevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryLighter, // Lighter blue
                  AppTheme.primaryDarker, // Darker blue
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.w),
            onPressed: () => Get.back(),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sermon',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'PIWC Stoneyburn',
                style: TextStyle(
                  color: AppTheme.warningColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          titleSpacing: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.bookmark_border,
                color: Colors.white,
                size: 24.w,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroImage(sermon.category),
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sermon.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        sermon.pastor,
                        style: TextStyle(
                          color: AppTheme.accentBlue,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.white.withValues(alpha: 0.5),
                            size: 14.w,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            sermon.date,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 13.sp,
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Icon(
                            Icons.access_time,
                            color: Colors.white.withValues(alpha: 0.5),
                            size: 14.w,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            sermon.duration,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      _buildMediaPlayer(sermon.duration),
                      SizedBox(height: 20.h),
                      _buildKeyScripture(),
                      SizedBox(height: 24.h),
                      _buildAboutSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroImage(String category) {
    return Container(
      width: double.infinity,
      height: 240.h,
      color: const Color(0xFF4A72FF), // Bright blue hero background
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mic,
                  color: Colors.white.withValues(alpha: 0.8),
                  size: 40.w,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              category,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaPlayer(String duration) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1B233D),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Progress Bar
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                width: double.infinity,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Container(
                width: 100.w, // Simulated progress
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF4A72FF),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Positioned(
                left: 96.w, // Position the thumb at the end of progress
                child: Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4A72FF),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '12:36',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 12.sp,
                ),
              ),
              Text(
                duration,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.fast_rewind, color: Colors.white, size: 32.w),
                onPressed: () {},
              ),
              SizedBox(width: 24.w),
              Container(
                width: 64.w,
                height: 64.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF4A72FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 40.w,
                ),
              ),
              SizedBox(width: 24.w),
              IconButton(
                icon: Icon(Icons.fast_forward, color: Colors.white, size: 32.w),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyScripture() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1B233D),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'KEY SCRIPTURE',
            style: TextStyle(
              color: AppTheme.accentBlue,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Hebrews 6:19',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About This Message',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          "In uncertain times, our hope is not wishful thinking but a firm anchor rooted in God's promises. This message explores Hebrews 6 and what it means to hold fast to hope.",
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 14.sp,
            height: 1.6,
          ),
        ),
        SizedBox(height: 20.h),
        // Tags
        Row(
          children: [
            _buildTag('#hope'),
            SizedBox(width: 12.w),
            _buildTag('#faith'),
            SizedBox(width: 12.w),
            _buildTag('#promises'),
          ],
        ),
        SizedBox(height: 24.h),
        // Share Button
        Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppTheme.primaryLighter, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.share, color: const Color(0xFF4A72FF), size: 20.w),
              SizedBox(width: 12.w),
              Text(
                'Share This Sermon',
                style: TextStyle(
                  color: const Color(0xFF4A72FF),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2846),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.7),
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
