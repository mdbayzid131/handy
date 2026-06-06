import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/notifications_controller.dart';
import 'package:handy/config/themes/app_theme.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notifications',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'PIWC Stoneyburn',
              style: TextStyle(
                color: AppTheme.warningColor, // Amber yellow matching design
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        titleSpacing: 0,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!controller.isSystemNotificationsEnabled.value)
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF5252), Color(0xFFFF416C)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.notifications_off,
                          color: Colors.white,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Notifications are off',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Tap to enable and stay connected with PIWC Stoneyburn',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        const Icon(Icons.chevron_right, color: Colors.white),
                      ],
                    ),
                  ),

                Text(
                  'Notification Preferences',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),

                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A223E),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF2A3355),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildPreferenceItem(
                        icon: Icons.notifications,
                        iconBgColor: const Color(0xFF2F45D1),
                        title: 'Sunday Service Reminder',
                        subtitle:
                            'Reminder every Saturday at 6:00 PM before Sunday service',
                        value: controller.sundayServiceReminder.value,
                        onChanged: (val) =>
                            controller.sundayServiceReminder.value = val,
                      ),
                      _buildDivider(),
                      _buildPreferenceItem(
                        icon: Icons.calendar_month,
                        iconBgColor: const Color(0xFF0F8A74),
                        title: 'Event Reminders',
                        subtitle: "1-hour reminder before events you've saved",
                        value: controller.eventReminders.value,
                        onChanged: (val) =>
                            controller.eventReminders.value = val,
                      ),
                      _buildDivider(),
                      _buildPreferenceItem(
                        icon: Icons.campaign,
                        iconBgColor: const Color(0xFFE54148),
                        title: 'New Announcements',
                        subtitle:
                            'Notified when the church posts new announcements',
                        value: controller.newAnnouncements.value,
                        onChanged: (val) =>
                            controller.newAnnouncements.value = val,
                      ),
                      _buildDivider(),
                      _buildPreferenceItem(
                        icon: Icons.play_circle_fill,
                        iconBgColor: const Color(0xFF7524AA),
                        title: 'New Sermons',
                        subtitle: 'Notified when a new sermon is uploaded',
                        value: controller.newSermons.value,
                        onChanged: (val) => controller.newSermons.value = val,
                      ),
                      _buildDivider(),
                      _buildPreferenceItem(
                        icon: Icons.volunteer_activism,
                        iconBgColor: const Color(0xFFDD6120),
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
        );
      }),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Color(0xFF2A3355),
      height: 1,
      thickness: 1,
      indent: 64, // To align with text
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
            child: Icon(icon, color: Colors.white, size: 24.sp),
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
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Color(0xFF8C93A8),
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
              activeThumbColor: const Color(0xFFFFB800),
              activeTrackColor: const Color(0xFF384370),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFF384370),
            ),
          ),
        ],
      ),
    );
  }
}
