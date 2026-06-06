import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/themes/app_theme.dart';

class WatchLiveView extends StatelessWidget {
  const WatchLiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppTheme.white, size: 20.w),
          onPressed: () => Get.back(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Watch Live',
              style: TextStyle(
                color: AppTheme.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'PIWC Stoneyburn',
              style: TextStyle(
                color: AppTheme.warningColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppTheme.red600,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: AppTheme.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  'LIVE',
                  style: TextStyle(
                    color: AppTheme.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
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
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Blue Background Header containing the Red Card
              Container(
                width: double.infinity,
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
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 30.h),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 40.h,
                      horizontal: 20.w,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppTheme.red700, // Red
                          AppTheme.deepRed, // Dark Red
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.black.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.videocam, color: AppTheme.white, size: 56.w),
                        SizedBox(height: 16.h),
                        Text(
                          "We're Live Now!",
                          style: TextStyle(
                            color: AppTheme.white,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "Sunday Worship Service",
                          style: TextStyle(
                            color: AppTheme.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "PIWC Stoneyburn",
                          style: TextStyle(
                            color: AppTheme.white.withValues(alpha: 0.7),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    Text(
                      'Watch on',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.white
                            : AppTheme.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // YouTube Live Option
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppTheme.red500,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              color: AppTheme.red500,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.ondemand_video,
                              color: AppTheme.white,
                              size: 24.w,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'YouTube Live',
                                  style: TextStyle(
                                    color: AppTheme.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Opens YouTube in browser',
                                  style: TextStyle(
                                    color: AppTheme.mutedTextColor,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 24.w,
                            height: 24.w,
                            decoration: const BoxDecoration(
                              color: AppTheme.red500,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              color: AppTheme.white,
                              size: 16.w,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Facebook Live Option
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppTheme.white.withValues(alpha: 0.05),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              color: AppTheme.standardBlue, // Facebook Blue
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.facebook,
                              color: AppTheme.white,
                              size: 28.w,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Facebook Live',
                                  style: TextStyle(
                                    color: AppTheme.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Opens Facebook in browser',
                                  style: TextStyle(
                                    color: AppTheme.mutedTextColor,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Watch Live Button
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppTheme.red600,
                            Color(0xFFFF5722),
                          ], // Red to Orange gradient
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.videocam, color: AppTheme.white, size: 24.w),
                          SizedBox(width: 8.w),
                          Text(
                            'Watch Live on YouTube Live',
                            style: TextStyle(
                              color: AppTheme.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.chevron_right,
                            color: AppTheme.white,
                            size: 20.w,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    Center(
                      child: Text(
                        'Opens in your browser · YouTube Live',
                        style: TextStyle(
                          color: AppTheme.mutedTextColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Service Times
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Service Times',
                            style: TextStyle(
                              color: AppTheme.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          _buildServiceTimeRow(
                            Icons.calendar_today,
                            'Every Sunday',
                          ),
                          SizedBox(height: 16.h),
                          _buildServiceTimeRow(
                            Icons.access_time,
                            '10:00 AM – 12:30 PM',
                          ),
                          SizedBox(height: 16.h),
                          _buildServiceTimeRow(
                            Icons.location_on,
                            '71 Stoneyburn Street, EH47 8JT',
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40.h),

                    Text(
                      'Recent Services',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.white
                            : AppTheme.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    _buildRecentServiceCard(
                      title: 'Sunday Service — 4 May 2026',
                      speaker: 'Pastor Emmanuel Asante',
                      time: '2h 15min · 4 May 2026',
                      iconColor: AppTheme.primaryLighter, // Blue
                    ),
                    _buildRecentServiceCard(
                      title: 'Sunday Service — 27 Apr 2026',
                      speaker: 'Elder Grace Mensah',
                      time: '2h 08min · 27 Apr 2026',
                      iconColor: AppTheme.red800, // Dark Red
                    ),
                    _buildRecentServiceCard(
                      title: 'Prayer Night — 25 Apr 2026',
                      speaker: 'PIWC Stoneyburn',
                      time: '1h 45min · 25 Apr 2026',
                      iconColor: AppTheme.purple900, // Purple
                    ),
                    _buildRecentServiceCard(
                      title: 'Sunday Service — 20 Apr 2026',
                      speaker: 'Deacon David Boateng',
                      time: '2h 02min · 20 Apr 2026',
                      iconColor: AppTheme.teal800, // Dark Green
                    ),

                    SizedBox(height: 24.h),

                    // Subscribe Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.red600, Color(0xFFFF5722)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.notifications,
                            color: AppTheme.white,
                            size: 28.w,
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Never miss a service',
                                  style: TextStyle(
                                    color: AppTheme.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Subscribe to our YouTube\nchannel for live notifications',
                                  style: TextStyle(
                                    color: AppTheme.white.withValues(alpha: 0.9),
                                    fontSize: 12.sp,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              'Subscribe',
                              style: TextStyle(
                                color: AppTheme.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceTimeRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.accentBlue, size: 20.w),
        SizedBox(width: 12.w),
        Text(
          text,
          style: TextStyle(color: AppTheme.white, fontSize: 15.sp),
        ),
      ],
    );
  }

  Widget _buildRecentServiceCard({
    required String title,
    required String speaker,
    required String time,
    required Color iconColor,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppTheme.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 70.w,
            height: 70.w,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Icon(Icons.play_arrow, color: AppTheme.white, size: 28.w),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppTheme.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  speaker,
                  style: TextStyle(
                    color: AppTheme.mutedTextColor,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: AppTheme.mutedTextColor,
                      size: 12.w,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      time,
                      style: TextStyle(
                        color: AppTheme.mutedTextColor,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: AppTheme.mutedTextColor, size: 24.w),
        ],
      ),
    );
  }
}
