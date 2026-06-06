import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/themes/app_theme.dart';
import '../../../data/models/prayer_wall_model.dart';
import '../../../core/widgets/custom_gradient_header.dart';
import '../controllers/prayer_wall_controller.dart';

class PrayerWallView extends GetView<PrayerWallController> {
  const PrayerWallView({super.key});

  void _showAddRequestBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppTheme.mutedTextColor,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      Text(
                        'Share a Request',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: AppTheme.accentBlue,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Your Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Obx(
                    () => TextField(
                      enabled: !controller.isAnonymous.value,
                      style: TextStyle(
                        color: controller.isAnonymous.value
                            ? Colors.white.withValues(alpha: 0.5)
                            : Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Anonymous',
                        hintStyle: const TextStyle(color: AppTheme.mutedTextColor),
                        filled: true,
                        fillColor: AppTheme.cardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Prayer as Anonymous',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Obx(
                        () => Checkbox(
                          value: controller.isAnonymous.value,
                          onChanged: (value) {
                            controller.isAnonymous.value = value ?? false;
                          },
                          activeColor: const Color(0xFF476BFF),
                          checkColor: Colors.white,
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Prayer Request',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    maxLines: 5,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Share what\'s on your heart...',
                      hintStyle: const TextStyle(color: AppTheme.mutedTextColor),
                      filled: true,
                      fillColor: AppTheme.cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Your request will be shared with the church family. You can choose to remain anonymous.',
                    style: TextStyle(
                      color: AppTheme.mutedTextColor,
                      fontSize: 12.sp,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
            // Header
            CustomGradientHeader(
              title: 'Prayer Wall',
              showBackButton: true,
              trailingWidget: ElevatedButton(
                onPressed: () => _showAddRequestBottomSheet(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.warningColor,
                  foregroundColor: const Color(0xFF0F172A),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, size: 18.w),
                    SizedBox(width: 4.w),
                    Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Toggle Buttons
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Obx(
                () => Container(
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: AppTheme.cardColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.isPrayerWall.value = true,
                          child: Container(
                            margin: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: controller.isPrayerWall.value
                                  ? AppTheme.accentBlue
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Prayer Wall',
                              style: TextStyle(
                                color: controller.isPrayerWall.value
                                    ? Colors.white
                                    : AppTheme.mutedTextColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.isPrayerWall.value = false,
                          child: Container(
                            margin: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: !controller.isPrayerWall.value
                                  ? AppTheme.accentBlue
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'My Requests',
                              style: TextStyle(
                                color: !controller.isPrayerWall.value
                                    ? Colors.white
                                    : AppTheme.mutedTextColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.h),
            // Tab Views
            Expanded(
              child: Obx(
                () => controller.isPrayerWall.value
                    ? _buildPrayerList(context, controller.requests)
                    : _buildEmptyState(context),
              ),
            ),
          ],
        ),
    );
  }

  Widget _buildPrayerList(BuildContext context, List<PrayerWallModel> list) {
    if (list.isEmpty) return _buildEmptyState(context);

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        final initial = item.name.isNotEmpty ? item.name[0].toUpperCase() : '?';

        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.primaryLighter,
                    radius: 20.r,
                    child: Text(
                      initial,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          item.date,
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
              SizedBox(height: 16.h),
              Text(
                item.request,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 15.sp,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.volunteer_activism,
                      color: AppTheme.mutedTextColor,
                      size: 16.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'I Prayed · ${item.praysCount}',
                      style: TextStyle(
                        color: AppTheme.mutedTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.volunteer_activism,
            color: AppTheme.mutedTextColor.withValues(alpha: 0.5),
            size: 64.w,
          ),
          SizedBox(height: 16.h),
          Text(
            'No requests yet',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Be the first to share a prayer request',
            style: TextStyle(color: AppTheme.mutedTextColor, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
