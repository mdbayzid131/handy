import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notifications_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1528),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notifications',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'PIWC Stoneyburn',
              style: TextStyle(
                color: Color(0xFFFFC107), // Amber yellow matching design
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        titleSpacing: 0,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Notifications are off',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Tap to enable and stay connected with PIWC Stoneyburn',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.chevron_right, color: Colors.white),
                      ],
                    ),
                  ),

                const Text(
                  'Notification Preferences',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

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
                const SizedBox(height: 16),
                const Text(
                  'Sunday service reminders are sent every Saturday at 6:00 PM. You can adjust or disable individual notifications at any time.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8C93A8),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF8C93A8),
                    fontSize: 13,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFFFFB800),
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
