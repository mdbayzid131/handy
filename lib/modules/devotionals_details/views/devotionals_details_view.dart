import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/themes/app_theme.dart';
import 'package:handy/modules/home/controllers/home_controller.dart';

import '../controllers/devotionals_details_controller.dart';
import '../../../core/widgets/shimmers/details_shimmer.dart';

class DevotionalsDetailsView extends GetView<DevotionalsDetailsController> {
  const DevotionalsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.backgroundColor
            : AppTheme.containerColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppTheme.white, size: 24.w),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          'Devotional',
          style: TextStyle(
            color: AppTheme.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.devotional.value == null) {
          return const DetailsShimmer();
        }

        final devotional = controller.devotional.value;
        if (devotional == null) {
          return const Center(child: Text('No devotional available'));
        }

        return RefreshIndicator(
          onRefresh: controller.refreshData,
          color: AppTheme.primaryColor,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              // Top Blue Header
              Container(
                width: double.infinity,
                color: AppTheme.royalBlue, // Royal Blue
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${devotional.dayLabel?.toUpperCase() ?? ''} · ${devotional.date?.toUpperCase() ?? ''}',
                      style: TextStyle(
                        color: AppTheme.white.withValues(alpha: 0.7),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      devotional.title ?? '',
                      style: TextStyle(
                        color: AppTheme.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Scripture Container
              Container(
                margin: EdgeInsets.all(20.w),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: AppTheme.containerColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        devotional.scriptureRef?.toUpperCase() ?? '',
                        style: TextStyle(
                          color: AppTheme.royalBlue,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        '"${devotional.scriptureQuote ?? ''}"',
                        style: TextStyle(
                          color: AppTheme.white,
                          fontSize: 16.sp,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Reflection Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.menu_book,
                          color: AppTheme.royalBlue,
                          size: 24.w,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Reflection',
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppTheme.white
                                : AppTheme.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      devotional.reflection ?? '',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.white.withValues(alpha: 0.9)
                            : AppTheme.black.withValues(alpha: 0.9),
                        fontSize: 15.sp,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              // Prayer Section
              Container(
                margin: EdgeInsets.all(20.w),
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppTheme.containerColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: const Color(0xFF9C27B0),
                          size: 20.w,
                        ), // Purple heart-like icon
                        SizedBox(width: 12.w),
                        Text(
                          'Prayer',
                          style: TextStyle(
                            color: AppTheme.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      devotional.prayer ?? '',
                      style: TextStyle(
                        color: AppTheme.mutedTextColor,
                        fontSize: 15.sp,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Obx(() {
                      final isReadStatus = controller.devotional.value?.isRead ?? false;
                      return isReadStatus
                          ? ElevatedButton(
                              onPressed: () {}, // Already read, do nothing
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.royalBlue,
                                minimumSize: Size(double.infinity, 56.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                elevation: 0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: AppTheme.white,
                                    size: 20.w,
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    'Mark as Read',
                                    style: TextStyle(
                                      color: AppTheme.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : OutlinedButton(
                              onPressed: () async {
                                await controller.markAsRead();
                                if (Get.isRegistered<HomeController>()) {
                                  Get.find<HomeController>().fetchDevotionalSummary();
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: AppTheme.royalBlue,
                                  width: 1.5,
                                ),
                                minimumSize: Size(double.infinity, 56.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: controller.isMarkingRead.value
                                  ? SizedBox(
                                      height: 20.h,
                                      width: 20.h,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppTheme.royalBlue,
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Mark as Read',
                                          style: TextStyle(
                                            color: AppTheme.royalBlue,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                            );
                    }),
                    SizedBox(height: 16.h),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: AppTheme.containerColor,
                          width: 1.5,
                        ),
                        minimumSize: Size(double.infinity, 56.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share,
                            color: AppTheme.royalBlue,
                            size: 20.w,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Share This Devotional',
                            style: TextStyle(
                              color: AppTheme.royalBlue,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
    );
  }),
);
  }
}
