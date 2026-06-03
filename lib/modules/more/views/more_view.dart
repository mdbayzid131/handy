import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../config/routes/app_pages.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarHeight: 90.h,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF2844B4), // Lighter blue
                Color(0xFF0A123D), // Darker blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'More',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'PIWC Stoneyburn',
                        style: TextStyle(
                          color: const Color(0xFFFFC107),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        titleSpacing: 20.w,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Features',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildFeaturesGrid(),
                  SizedBox(height: 32.h),
                  Text(
                    'Connect With Us',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildConnectCard(),
                  SizedBox(height: 24.h),
                  _buildMissionCard(),
                  SizedBox(height: 40.h), // padding at bottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildFeaturesGrid() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFeatureItem(
              Icons.volunteer_activism,
              'Prayer Wall',
              [const Color(0xFFCE93D8), const Color(0xFF8E24AA)],
            ),
            _buildFeatureItem(
              Icons.menu_book,
              'Devotionals',
              [const Color(0xFFFFB74D), const Color(0xFFF57C00)],
            ),
            _buildFeatureItem(
              Icons.groups,
              'Community',
              [const Color(0xFF4DB6AC), const Color(0xFF00796B)],
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFeatureItem(
              Icons.book,
              'Bible',
              [const Color(0xFF81C784), const Color(0xFF388E3C)],
            ),
            _buildFeatureItem(
              Icons.person,
              'My Profile',
              [const Color(0xFF64B5F6), const Color(0xFF1976D2)],
              onTap: () => Get.toNamed(AppRoutes.PROFILE),
            ),
            _buildFeatureItem(
              Icons.settings,
              'Settings',
              [const Color(0xFFB0BEC5), const Color(0xFF607D8B)],
              onTap: () => Get.toNamed(AppRoutes.SETTINGS),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, List<Color> gradientColors, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 75.w,
            height: 75.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradientColors,
              ),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Icon(icon, color: Colors.white, size: 32.w),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E37AB), // Blue card background
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFFC107),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'THE CHURCH OF PENTECOST · UK',
              style: TextStyle(
                color: const Color(0xFF091244),
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'PIWC Stoneyburn',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24.h),
          _buildConnectRow(
            Icons.location_on,
            'Address',
            '71 Stoneyburn Street, Stoneyburn,\nEH47 8JT',
          ),
          SizedBox(height: 20.h),
          _buildConnectRow(
            Icons.access_time,
            'Sunday Service',
            '10:00 AM – 12:30 PM',
          ),
          SizedBox(height: 20.h),
          _buildConnectRow(
            Icons.email,
            'Email',
            'info@piwcstoneyburn.org',
          ),
          SizedBox(height: 20.h),
          _buildConnectRow(
            Icons.language,
            'Website',
            'www.piwcstoneyburn.org',
          ),
        ],
      ),
    );
  }

  Widget _buildConnectRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: const Color(0xFFFFC107), size: 20.w),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMissionCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFC107),
            Color(0xFFFF9800),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OUR MISSION',
            style: TextStyle(
              color: const Color(0xFF091244),
              fontSize: 16.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            '"To make heaven, to take as many people as possible with us, and to have a positive impact on society."',
            style: TextStyle(
              color: const Color(0xFF091244).withOpacity(0.8),
              fontSize: 16.sp,
              fontStyle: FontStyle.italic,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}