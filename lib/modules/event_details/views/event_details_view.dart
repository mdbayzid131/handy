import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/event_details_controller.dart';
import 'package:handy/config/themes/app_theme.dart';
import 'package:handy/core/widgets/custom_gradient_header.dart';
import '../../../core/widgets/shimmers/details_shimmer.dart';

class EventDetailsView extends GetView<EventDetailsController> {
  const EventDetailsView({super.key});

  Color _getCategoryColor(String? colorHex) {
    if (colorHex == null || colorHex.isEmpty) {
      return const Color(0xFF132488);
    }
    try {
      String hex = colorHex.toUpperCase().replaceAll("#", "");
      if (hex.length == 6) {
        hex = "FF$hex";
      }
      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      return const Color(0xFF132488);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value &&
          controller.event.value.description == null) {
        return const Scaffold(
          body: Column(
            children: [
              CustomGradientHeader(
                title: 'Event Details',
                subtitle: 'PIWC Stoneyburn',
                showBackButton: true,
              ),
              Expanded(child: DetailsShimmer()),
            ],
          ),
        );
      }

      final event = controller.event.value;
      final primaryColor = _getCategoryColor(event.categoryColor);

      return Scaffold(
        body: Column(
          children: [
            const CustomGradientHeader(
              title: 'Event Details',
              subtitle: 'PIWC Stoneyburn',
              showBackButton: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Section / Colored Block
                    if (event.image != null && event.image!.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            () => Scaffold(
                              backgroundColor: Colors.black,
                              body: GestureDetector(
                                onTap: () => Get.back(),
                                child: Center(
                                  child: InteractiveViewer(
                                    panEnabled: true,
                                    minScale: 0.5,
                                    maxScale: 4,
                                    child: Image.network(
                                      event.image!,
                                      fit: BoxFit.contain,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            transition: Transition.fadeIn,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 250.h,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            image: DecorationImage(
                              image: NetworkImage(event.image!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    else
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 30.h, bottom: 40.h),
                        decoration: BoxDecoration(color: primaryColor),
                        child: Column(
                          children: [
                            Container(
                              width: 80.w,
                              height: 80.w,
                              decoration: BoxDecoration(
                                color: AppTheme.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.calendar_today,
                                color: AppTheme.white,
                                size: 36.w,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                event.categoryLabel.toUpperCase(),
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
                    // Content Details Section
                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppTheme.white
                                  : AppTheme.black,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 20.h),

                          // Information Card
                          Container(
                            decoration: BoxDecoration(
                              color: AppTheme.containerColor,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: AppTheme.secondaryColor,
                              ),
                            ),
                            child: Column(
                              children: [
                                _buildDetailRow(
                                  Icons.calendar_today,
                                  'DATE',
                                  event.date,
                                  primaryColor,
                                ),
                                Divider(
                                  color: AppTheme.secondaryColor,
                                  height: 1,
                                  indent: 60.w,
                                ),
                                _buildDetailRow(
                                  Icons.access_time,
                                  'TIME',
                                  event.time,
                                  primaryColor,
                                ),
                                Divider(
                                  color: AppTheme.secondaryColor,
                                  height: 1,
                                  indent: 60.w,
                                ),
                                _buildDetailRow(
                                  Icons.location_on,
                                  'LOCATION',
                                  event.location,
                                  primaryColor,
                                ),
                                Divider(
                                  color: AppTheme.secondaryColor,
                                  height: 1,
                                  indent: 60.w,
                                ),
                                _buildDetailRow(
                                  Icons.people,
                                  'ATTENDING',
                                  '${event.attendingCount} people',
                                  primaryColor,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 32.h),
                          Text(
                            'About This Event',
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppTheme.white
                                  : AppTheme.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            event.description ?? 'No description provided.',
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppTheme.white.withValues(alpha: 0.6)
                                  : AppTheme.black.withValues(alpha: 0.6),
                              fontSize: 15.sp,
                              height: 1.6,
                            ),
                          ),

                          SizedBox(height: 40.h),

                          // Bottom Buttons
                          if (controller.isRSVPd.value)
                            Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: controller.isRsvpLoading.value
                                        ? null
                                        : () => controller.toggleRSVP(),
                                    icon: controller.isRsvpLoading.value
                                        ? SizedBox(
                                            width: 24.w,
                                            height: 24.w,
                                            child:
                                                const CircularProgressIndicator(
                                                  color: AppTheme.white,
                                                  strokeWidth: 2,
                                                ),
                                          )
                                        : Icon(
                                            Icons.check_circle,
                                            color: AppTheme.white,
                                            size: 24.w,
                                          ),
                                    label: Text(
                                      "You're Going!",
                                      style: TextStyle(
                                        color: AppTheme.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(
                                        0xFF22C55E,
                                      ), // Green
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.h,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      elevation: 0,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'We look forward to seeing you there! 🎉',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppTheme.white.withValues(alpha: 0.7)
                                        : AppTheme.black.withValues(alpha: 0.7),
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            )
                          else
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: controller.isRsvpLoading.value
                                    ? null
                                    : () {
                                        controller.toggleRSVP();
                                      },
                                icon: controller.isRsvpLoading.value
                                    ? SizedBox(
                                        width: 20.w,
                                        height: 20.w,
                                        child: const CircularProgressIndicator(
                                          color: AppTheme.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Icon(
                                        Icons.calendar_today,
                                        color: AppTheme.white,
                                        size: 20.w,
                                      ),
                                label: Text(
                                  "RSVP for This Event",
                                  style: TextStyle(
                                    color: AppTheme.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),

                          SizedBox(height: 16.h),

                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: controller.addToCalendar,
                              icon: Icon(
                                Icons.calendar_today,
                                color: primaryColor,
                                size: 20.w,
                              ),
                              label: Text(
                                "Add to Calendar",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                side: BorderSide(
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppTheme.white
                                      : AppTheme.containerColor,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
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
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value,
    Color primaryColor,
  ) {
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
            child: Icon(
              icon,
              color: primaryColor.withValues(alpha: 0.8),
              size: 20.w,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: AppTheme.white.withValues(alpha: 0.5),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    color: AppTheme.white,
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
