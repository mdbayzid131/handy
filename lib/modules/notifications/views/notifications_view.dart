import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/notifications_controller.dart';
import 'package:handy/config/themes/app_theme.dart';
import 'package:handy/core/widgets/custom_gradient_header.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomGradientHeader(
            title: 'Notifications',
            subtitle: 'PIWC Stoneyburn',
            showBackButton: true,
          ),
          Expanded(
            child: Obx(() {
              return RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 1));
                },
                color: AppTheme.primaryColor,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!controller.isSystemNotificationsEnabled.value)
                          GestureDetector(
                            onTap: () => controller.toggleSystemNotifications(),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 24.h),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppTheme.accentRed, AppTheme.pinkRed],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.notifications_off,
                                  color: AppTheme.white,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Notifications are off',
                                        style: TextStyle(
                                          color: AppTheme.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        'Tap to enable and stay connected with PIWC Stoneyburn',
                                        style: TextStyle(
                                          color: AppTheme.white,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                const Icon(
                                  Icons.chevron_right,
                                  color: AppTheme.white,
                                ),
                              ],
                            ),
                          ),
                        ),

                        Text(
                          'Notification Preferences',
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
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
                            border: Border.all(
                              color: AppTheme.secondaryColor,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              _buildPreferenceItem(
                                icon: Icons.notifications,
                                iconBgColor: AppTheme.indigo,
                                title: 'Sunday Service Reminder',
                                subtitle:
                                    'Reminder every Saturday at 6:00 PM before Sunday service',
                                value: controller.sundayServiceReminder.value,
                                onChanged: (val) =>
                                    controller.sundayServiceReminder.value =
                                        val,
                              ),
                              _buildDivider(),
                              _buildPreferenceItem(
                                icon: Icons.calendar_month,
                                iconBgColor: AppTheme.deepTeal,
                                title: 'Event Reminders',
                                subtitle:
                                    "1-hour reminder before events you've saved",
                                value: controller.eventReminders.value,
                                onChanged: (val) =>
                                    controller.eventReminders.value = val,
                              ),
                              _buildDivider(),
                              _buildPreferenceItem(
                                icon: Icons.play_circle_fill,
                                iconBgColor: AppTheme.deepPurple,
                                title: 'New Sermons',
                                subtitle:
                                    'Notified when a new sermon is uploaded',
                                value: controller.newSermons.value,
                                onChanged: (val) =>
                                    controller.newSermons.value = val,
                              ),
                              _buildDivider(),
                              _buildPreferenceItem(
                                icon: Icons.volunteer_activism,
                                iconBgColor: AppTheme.burntOrange,
                                title: 'Prayer Updates',
                                subtitle:
                                    'Notified when someone prays for your request',
                                value: controller.prayerUpdates.value,
                                onChanged: (val) =>
                                    controller.prayerUpdates.value = val,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: AppTheme.secondaryColor,
      height: 1,
      thickness: 1,
      indent: 64.w, // To align with text
    );
  }

  Widget _buildPreferenceItem({
    required IconData icon,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: AppTheme.white, size: 24.sp),
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
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppTheme.mutedTextVariant,
                    fontSize: 10.sp,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: AppTheme.yellowAccentVariant,
              activeTrackColor: AppTheme.slateBlue,
              inactiveThumbColor: AppTheme.white,
              inactiveTrackColor: AppTheme.slateBlue,
            ),
          ),
        ],
      ),
    );
  }
}
