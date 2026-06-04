import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:handy/modules/bottom_nab_bar/controllers/bottom_nab_bar.dart';
import '../../../config/routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0F172A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.w),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white, size: 24.w),
            onPressed: () => Get.toNamed(AppRoutes.SETTINGS),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Blue Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 40.h, bottom: 40.h),
              color: const Color(0xFF476BFF), // Royal Blue
              child: Column(
                children: [
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'JD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Member since January 2023',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'ACTIVE MEMBER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Giving Summary
                  Text(
                    'Giving Summary',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A2340),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Column(
                      children: [
                        _buildGivingRow('Total Given (2025)', '\$475.00'),
                        Divider(
                          color: Colors.white.withOpacity(0.05),
                          height: 1,
                          indent: 20.w,
                          endIndent: 20.w,
                        ),
                        _buildGivingRow('Last Gift', '\$250.00 · Apr 27'),
                        Divider(
                          color: Colors.white.withOpacity(0.05),
                          height: 1,
                          indent: 20.w,
                          endIndent: 20.w,
                        ),
                        _buildGivingRow(
                          'Giving Streak',
                          '4 weeks',
                          isLastBold: true,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Saved Sermons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Saved Sermons',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.find<BottomNavBarController>().changeTab(1);
                          Get.back();
                        },
                        child: Text(
                          'See all',
                          style: TextStyle(
                            color: const Color(0xFF3B68E7),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  _buildSermonCard(
                    'The Anchor of Hope',
                    'Pastor James Okafor · May 4, 2025',
                    onTap: () {
                      Get.toNamed(AppRoutes.SERMON_DITAILS);
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildSermonCard(
                    'Sing a New Song',
                    'Deacon Michael Eze · Apr 13, 2025',
                    onTap: () {
                      Get.toNamed(AppRoutes.SERMON_DITAILS);
                    },
                  ),
                  SizedBox(height: 32.h),

                  // Account
                  Text(
                    'Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A2340),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Column(
                      children: [
                        _buildAccountRow(
                          Icons.notifications,
                          const Color(0xFF3B68E7),
                          'Notifications',
                          onTap: () {
                            Get.toNamed(AppRoutes.NOTIFICATION);
                          },
                        ),
                        Divider(
                          color: Colors.white.withOpacity(0.05),
                          height: 1,
                          indent: 60.w,
                          endIndent: 20.w,
                        ),
                        _buildAccountRow(
                          Icons.settings,
                          const Color(0xFF3B68E7),
                          'Settings',
                          onTap: () => Get.toNamed(AppRoutes.SETTINGS),
                        ),
                        Divider(
                          color: Colors.white.withOpacity(0.05),
                          height: 1,
                          indent: 60.w,
                          endIndent: 20.w,
                        ),
                        _buildAccountRow(
                          Icons.security,
                          const Color(0xFF3B68E7),
                          'Privacy Policy',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),

                  Center(
                    child: Text(
                      'PIWC Stoneyburn · v1.0.0',
                      style: TextStyle(
                        color: const Color(0xFF8E99AF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGivingRow(
    String label,
    String value, {
    bool isLastBold = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: const Color(0xFF8E99AF), fontSize: 15.sp),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSermonCard(
    String title,
    String subtitle, {
    GestureTapCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2340),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF3B68E7).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.play_arrow,
                color: const Color(0xFF476BFF), // A bit brighter
                size: 24.w,
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
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: const Color(0xFF8E99AF),
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF8E99AF),
              size: 20.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountRow(
    IconData icon,
    Color iconColor,
    String title, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: iconColor, size: 20.w),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF8E99AF),
              size: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}
