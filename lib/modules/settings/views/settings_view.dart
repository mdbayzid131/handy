import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:handy/config/themes/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/settings_controller.dart';
import 'package:handy/core/widgets/custom_gradient_header.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomGradientHeader(
            title: 'Settings',
            subtitle: 'PIWC Stoneyburn',
            showBackButton: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.white
                          : AppTheme.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildNotificationsCard(),
                  SizedBox(height: 32.h),
                  Text(
                    'Appearance',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.white
                          : AppTheme.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildAppearanceCard(context),
                  SizedBox(height: 32.h),
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
                  _buildAccountCard(context),
                  SizedBox(height: 32.h),
                  Text(
                    'About',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.white
                          : AppTheme.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildAboutCard(),
                  SizedBox(height: 40.h),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Made with ',
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppTheme.white.withValues(alpha: 0.5)
                                  : AppTheme.black.withValues(alpha: 0.5),
                              fontSize: 13.sp,
                            ),
                          ),
                          TextSpan(
                            text: '❤️',
                            style: TextStyle(fontSize: 13.sp),
                          ),
                          TextSpan(
                            text: ' for the PIWC Stoneyburn family',
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppTheme.white.withValues(alpha: 0.5)
                                  : AppTheme.black.withValues(alpha: 0.5),
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppTheme.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          _buildSwitchRow(
            'New Sermons',
            'When a new sermon is posted',
            controller.newSermons,
          ),
          Divider(
            color: AppTheme.white.withValues(alpha: 0.05),
            height: 1,
            indent: 20.w,
            endIndent: 20.w,
          ),
          _buildSwitchRow(
            'Events',
            'Upcoming event reminders',
            controller.events,
          ),
          Divider(
            color: AppTheme.white.withValues(alpha: 0.05),
            height: 1,
            indent: 20.w,
            endIndent: 20.w,
          ),
          _buildSwitchRow(
            'Prayer Updates',
            'When someone prays for your request',
            controller.prayerUpdates,
          ),
          Divider(
            color: AppTheme.white.withValues(alpha: 0.05),
            height: 1,
            indent: 20.w,
            endIndent: 20.w,
          ),
          _buildSwitchRow(
            'Daily Devotionals',
            'Morning devotional reminder',
            controller.dailyDevotionals,
          ),
          Divider(
            color: AppTheme.white.withValues(alpha: 0.05),
            height: 1,
            indent: 20.w,
            endIndent: 20.w,
          ),
          _buildSwitchRow(
            'Announcements',
            'Important church announcements',
            controller.announcements,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAppearanceCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppTheme.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dark Mode',
                        style: TextStyle(
                          color: AppTheme.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Toggle application theme',
                        style: TextStyle(
                          color: AppTheme.white.withValues(alpha: 0.5),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (val) {
                    Get.changeThemeMode(val ? ThemeMode.dark : ThemeMode.light);
                  },
                  activeThumbColor: AppTheme.white,
                  activeTrackColor: AppTheme.accentBlue,
                  inactiveThumbColor: AppTheme.white,
                  inactiveTrackColor: AppTheme.white.withValues(alpha: 0.1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppTheme.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 4.h,
            ),
            title: Text(
              'Change Password',
              style: TextStyle(
                color: AppTheme.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: AppTheme.white.withValues(alpha: 0.5),
              size: 24.w,
            ),
            onTap: () {
              _showChangePasswordBottomSheet(context);
            },
          ),
        ],
      ),
    );
  }

  void _showChangePasswordBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.85,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Header
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: AppTheme.white,
                    size: 20.w,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                        color: AppTheme.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.w), // Balance for centering
              ],
            ),
            SizedBox(height: 32.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Change Password',
                      style: TextStyle(
                        color: AppTheme.white.withValues(alpha: 0.7),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    const CustomTextField(
                      label: 'Old Password',
                      hintText: 'Enter Old Password',
                      obscureText: true,
                    ),
                    SizedBox(height: 20.h),
                    const CustomTextField(
                      label: 'New Password',
                      hintText: 'Enter New Password',
                      obscureText: true,
                    ),
                    SizedBox(height: 20.h),
                    const CustomTextField(
                      label: 'Confirm Password',
                      hintText: 'Enter Confirm Password',
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),
            // Save Button
            CustomButton(
              text: 'Save',
              backgroundColor: AppTheme.orange500,
              onPressed: () {
                Get.back();
                Get.snackbar(
                  'Success',
                  'Password changed successfully',
                  backgroundColor: Colors.green,
                  colorText: AppTheme.white,
                );
              },
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildSwitchRow(
    String title,
    String subtitle,
    RxBool value, {
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppTheme.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppTheme.white.withValues(alpha: 0.5),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Switch(
              value: value.value,
              onChanged: (val) => value.value = val,
              activeThumbColor: AppTheme.white,
              activeTrackColor: AppTheme.accentBlue, // Royal Blue
              inactiveThumbColor: AppTheme.white,
              inactiveTrackColor: AppTheme.white.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppTheme.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          _buildInfoRow('App Version', '1.0.0'),
          Divider(
            color: AppTheme.white.withValues(alpha: 0.05),
            height: 1,
            indent: 20.w,
            endIndent: 20.w,
          ),
          _buildInfoRow('Church', 'PIWC Stoneyburn', isValueBold: true),
          Divider(
            color: AppTheme.white.withValues(alpha: 0.05),
            height: 1,
            indent: 20.w,
            endIndent: 20.w,
          ),
          _buildInfoRow(
            'Website',
            'gracecommunity.church',
            valueColor: AppTheme.accentBlue,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    bool isValueBold = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppTheme.white.withValues(alpha: 0.5),
              fontSize: 15.sp,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? AppTheme.white,
              fontSize: 15.sp,
              fontWeight: isValueBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
