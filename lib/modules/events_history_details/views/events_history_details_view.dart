import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/events_history_details_controller.dart';

class EventsHistoryDetailsView extends GetView<EventsHistoryDetailsController> {
  const EventsHistoryDetailsView({super.key});

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Study':
        return const Color(0xFFFF8C00); // Orange
      case 'Worship':
        return const Color(0xFF3B68E7); // Royal Blue
      case 'Youth':
        return const Color(0xFFFF5252); // Coral/Red
      case 'Prayer':
        return const Color(0xFFB388FF); // Purple
      case 'Community':
        return const Color(0xFF26A69A); // Teal
      default:
        return const Color(0xFF132488); // Default Blue
    }
  }

  @override
  Widget build(BuildContext context) {
    final event = controller.event;
    final primaryColor = _getCategoryColor(event.category);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.w),
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
            Text(
              'Event History Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'PIWC Stoneyburn',
              style: TextStyle(
                color: const Color(0xFFFFC107),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section / Colored Block
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 30.h, bottom: 40.h),
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              child: Column(
                children: [
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.calendar_today, color: Colors.white, size: 36.w),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      event.category.toUpperCase(),
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
            // Content Details Section
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  
                  // Information Card
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2336),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow(Icons.calendar_today, 'DATE', event.date, primaryColor),
                        Divider(color: Colors.white.withValues(alpha: 0.05), height: 1, indent: 60.w),
                        _buildDetailRow(Icons.access_time, 'TIME', event.time, primaryColor),
                        Divider(color: Colors.white.withValues(alpha: 0.05), height: 1, indent: 60.w),
                        _buildDetailRow(Icons.location_on, 'LOCATION', event.location, primaryColor),
                        Divider(color: Colors.white.withValues(alpha: 0.05), height: 1, indent: 60.w),
                        _buildDetailRow(Icons.people, 'ATTENDED', '${event.attendeeCount} people', primaryColor),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 32.h),
                  Text(
                    'About This Event',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    event.description,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 15.sp,
                      height: 1.6,
                    ),
                  ),
                  
                  SizedBox(height: 40.h),
                  
                  // Bottom Buttons
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.check_circle, color: Colors.white, size: 24.w),
                      label: Text(
                        "Event Completed",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade700,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, Color primaryColor) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: primaryColor.withValues(alpha: 0.8), size: 20.w),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
