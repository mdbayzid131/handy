import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:handy/config/themes/app_theme.dart';
import 'package:handy/modules/bottom_nab_bar/controllers/bottom_nab_bar.dart';
import '../../../config/routes/app_pages.dart';
import '../../../core/widgets/cards/sermon_card_widget.dart';
import '../../../data/models/sermons_model.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopHeader(context),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGivingSummary(context),
                    SizedBox(height: 32.h),
                    _buildSavedSermons(context),
                    SizedBox(height: 32.h),
                    _buildAccountSection(context),
                    SizedBox(height: 16.h),
                    _buildDeleteAccountSection(context),
                    SizedBox(height: 40.h),
                    _buildVersionInfo(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppTheme.backgroundColor
          : AppTheme.containerColor,
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
    );
  }

  Widget _buildTopHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 40.h),
      color: AppTheme.royalBlue,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40.h),
            child: Column(
              children: [
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: AppTheme.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'JD',
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'John Doe',
                  style: TextStyle(
                    color: AppTheme.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Member since January 2023',
                  style: TextStyle(
                    color: AppTheme.white.withValues(alpha: 0.7),
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
                    color: AppTheme.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'ACTIVE MEMBER',
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16.h,
            right: 16.w,
            child: ElevatedButton(
              onPressed: () => _showLogoutDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5252),
                padding: EdgeInsets.symmetric(
                  horizontal: 6.w,
                  vertical: 2.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  color: AppTheme.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGivingSummary(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Giving Summary',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white
                : AppTheme.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.containerColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppTheme.secondaryColor),
          ),
          child: Column(
            children: [
              _buildGivingRow('Total Given (2025)', '\$475.00'),
              Divider(
                color: AppTheme.secondaryColor,
                height: 1,
                indent: 20.w,
                endIndent: 20.w,
              ),
              _buildGivingRow('Last Gift', '\$250.00 · Apr 27'),
              Divider(
                color: AppTheme.secondaryColor,
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
      ],
    );
  }

  Widget _buildSavedSermons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Saved Sermons',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.white
                    : AppTheme.black,
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
                  color: AppTheme.accentBlue,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        SermonCardWidget(
          sermon: Sermon(
            id: '1',
            category: 'FAITH',
            title: 'The Anchor of Hope',
            pastor: 'Pastor James Okafor',
            date: 'May 4, 2025',
            duration: '45 min',
          ),
          onTap: () {
            Get.toNamed(AppRoutes.SERMON_DITAILS);
          },
        ),
        SizedBox(height: 12.h),
        SermonCardWidget(
          sermon: Sermon(
            id: '2',
            category: 'WORSHIP',
            title: 'Sing a New Song',
            pastor: 'Deacon Michael Eze',
            date: 'Apr 13, 2025',
            duration: '38 min',
          ),
          onTap: () {
            Get.toNamed(AppRoutes.SERMON_DITAILS);
          },
        ),
      ],
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white
                : AppTheme.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.containerColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppTheme.secondaryColor),
          ),
          child: Column(
            children: [
              _buildAccountRow(
                Icons.notifications,
                AppTheme.accentBlue,
                'Notifications',
                onTap: () {
                  Get.toNamed(AppRoutes.NOTIFICATION);
                },
              ),
              Divider(
                color: AppTheme.secondaryColor,
                height: 1,
                indent: 60.w,
                endIndent: 20.w,
              ),
              _buildAccountRow(
                Icons.settings,
                AppTheme.accentBlue,
                'Settings',
                onTap: () => Get.toNamed(AppRoutes.SETTINGS),
              ),
              Divider(
                color: AppTheme.secondaryColor,
                height: 1,
                indent: 60.w,
                endIndent: 20.w,
              ),
              _buildAccountRow(
                Icons.security,
                AppTheme.accentBlue,
                'Privacy Policy',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDeleteAccountSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.containerColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppTheme.secondaryColor),
      ),
      child: _buildAccountRow(
        Icons.delete_outline,
        AppTheme.accentRed,
        'Delete Account',
        textColor: AppTheme.accentRed,
        onTap: () => _showDeleteAccountDialog(context),
      ),
    );
  }

  Widget _buildVersionInfo() {
    return Center(
      child: Text(
        'PIWC Stoneyburn · v1.0.0',
        style: TextStyle(
          color: AppTheme.mutedTextColor,
          fontSize: 12.sp,
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
            style: TextStyle(color: AppTheme.mutedTextColor, fontSize: 15.sp),
          ),
          Text(
            value,
            style: TextStyle(
              color: AppTheme.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildAccountRow(
    IconData icon,
    Color iconColor,
    String title, {
    VoidCallback? onTap,
    Color? textColor,
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
                color: iconColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: iconColor, size: 20.w),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor ?? AppTheme.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppTheme.mutedTextColor,
              size: 20.w,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppTheme.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.logout_rounded,
                  color: AppTheme.accentRed,
                  size: 48.w,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Logout',
                  style: TextStyle(
                    color: AppTheme.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Are you sure you want to log out of your account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.white.withValues(alpha: 0.7),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: AppTheme.white.withValues(alpha: 0.2),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppTheme.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          //Get.offAllNamed(AppRoutes.LOGIN);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentRed,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            color: AppTheme.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppTheme.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.delete_outline,
                  color: AppTheme.accentRed,
                  size: 48.w,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Delete Account',
                  style: TextStyle(
                    color: AppTheme.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Are you sure you want to delete your account? This action cannot be undone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.white.withValues(alpha: 0.7),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: AppTheme.white.withValues(alpha: 0.2),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppTheme.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          // Add your account deletion logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentRed,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            color: AppTheme.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
