import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/themes/app_theme.dart';
import 'shimmer_helper.dart';

class EventCardShimmer extends StatelessWidget {
  const EventCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppTheme.containerColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ShimmerHelper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Colored Header Placeholder
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
              child: Row(
                children: [
                  ShimmerContainer(width: 16.w, height: 16.w, shape: BoxShape.circle),
                  SizedBox(width: 8.w),
                  ShimmerContainer(width: 80.w, height: 14.h),
                ],
              ),
            ),
            // Event Details Placeholder
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  ShimmerContainer(width: 200.w, height: 18.h),
                  SizedBox(height: 12.h),
                  // Time
                  Row(
                    children: [
                      ShimmerContainer(width: 14.w, height: 14.w, shape: BoxShape.circle),
                      SizedBox(width: 8.w),
                      ShimmerContainer(width: 120.w, height: 14.h),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  // Location
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerContainer(width: 14.w, height: 14.w, shape: BoxShape.circle),
                      SizedBox(width: 8.w),
                      ShimmerContainer(width: 150.w, height: 14.h),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Bottom Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerContainer(width: 80.w, height: 26.h, borderRadius: 12.r),
                      ShimmerContainer(width: 60.w, height: 28.h, borderRadius: 20.r),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
