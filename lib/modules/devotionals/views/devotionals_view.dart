import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/routes/app_pages.dart';
import 'package:handy/config/themes/app_theme.dart';
import '../controllers/devotionals_controller.dart';
import '../../../core/widgets/shimmers/shimmer_helper.dart';

class DevotionalsView extends GetView<DevotionalsController> {
  const DevotionalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarHeight: 110.h,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppTheme.white, size: 24.w),
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Devotionals',
              style: TextStyle(
                color: AppTheme.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'PIWC Stoneyburn',
              style: TextStyle(
                color: AppTheme.warningColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Banner Fixed Below AppBar
            Container(
              margin: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 24.h,
                bottom: 24.h,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: AppTheme.containerColor,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppTheme.warningColor.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.wb_sunny,
                    color: AppTheme.warningColor,
                    size: 24.w,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Text(
                      'Read today\'s devotional and start your day with God',
                      style: TextStyle(
                        color: AppTheme.accentBlue,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.refreshData,
                color: AppTheme.primaryColor,
                child: Obx(() {
                  if (controller.isLoading.value &&
                      controller.devotionalsList.isEmpty) {
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 16.h),
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: AppTheme.containerColor,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: AppTheme.secondaryColor),
                          ),
                          child: ShimmerHelper(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 80.w,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ShimmerContainer(width: 40.w, height: 10.h),
                                      SizedBox(height: 4.h),
                                      ShimmerContainer(width: 60.w, height: 10.h),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ShimmerContainer(width: double.infinity, height: 12.h),
                                      SizedBox(height: 4.h),
                                      ShimmerContainer(width: 100.w, height: 12.h),
                                      SizedBox(height: 8.h),
                                      ShimmerContainer(width: double.infinity, height: 12.h),
                                      SizedBox(height: 4.h),
                                      ShimmerContainer(width: 150.w, height: 12.h),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  if (controller.devotionalsList.isEmpty) {
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(height: 100.h),
                        Center(
                          child: Text(
                            'No devotionals found',
                            style: TextStyle(
                              color: AppTheme.mutedTextColor,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return ListView.builder(
                    controller: controller.scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 0,
                    ),
                    itemCount: controller.devotionalsList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == controller.devotionalsList.length) {
                        return Obx(() {
                          if (controller.isLoadMore.value) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        });
                      }

                      final item = controller.devotionalsList[index];
                      final isSelected = item.isRead ?? false;

                      return GestureDetector(
                        onTap: () {
                          if (item.id != null) {
                            Get.toNamed(
                              AppRoutes.DEVOTIONALS_DETAILS,
                              arguments: item.id,
                            );
                          } else {
                            Get.toNamed(AppRoutes.DEVOTIONALS_DETAILS);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 16.h),
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppTheme.accentBlue
                                : AppTheme.containerColor,
                            borderRadius: BorderRadius.circular(16.r),
                            border: isSelected
                                ? null
                                : Border.all(color: AppTheme.secondaryColor),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 80.w,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      item.dayLabel ?? '',
                                      style: TextStyle(
                                        color: isSelected
                                            ? AppTheme.warningColor
                                            : AppTheme.mutedTextColor,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      item.date ?? '',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: isSelected
                                            ? AppTheme.white
                                            : AppTheme.mutedTextColor,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title ?? '',
                                      style: TextStyle(
                                        color: AppTheme.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      item.scriptureRef ?? '',
                                      style: TextStyle(
                                        color: isSelected
                                            ? AppTheme.warningColor
                                            : AppTheme.accentBlue,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      item.reflectionPreview ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: isSelected
                                            ? AppTheme.white.withValues(
                                                alpha: 0.8,
                                              )
                                            : AppTheme.mutedTextColor,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                Icons.chevron_right,
                                color: isSelected
                                    ? AppTheme.white.withValues(alpha: 0.8)
                                    : AppTheme.mutedTextColor,
                                size: 20.w,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
