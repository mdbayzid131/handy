import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/themes/app_theme.dart';
import 'shimmer_helper.dart';

class SermonCardShimmer extends StatelessWidget {
  const SermonCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppTheme.containerColor, // Provides base background
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppTheme.secondaryColor, width: 1),
      ),
      child: ShimmerHelper(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image Placeholder
            ShimmerContainer(
              width: 80.w,
              height: 80.w,
              borderRadius: 16.r,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Placeholder
                  ShimmerContainer(width: 60.w, height: 10.h),
                  SizedBox(height: 8.h),
                  // Title Placeholder
                  ShimmerContainer(width: double.infinity, height: 16.h),
                  SizedBox(height: 6.h),
                  // Speaker Placeholder
                  ShimmerContainer(width: 120.w, height: 14.h),
                  SizedBox(height: 12.h),
                  // Bottom Row (Date & Duration)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerContainer(width: 80.w, height: 12.h),
                      ShimmerContainer(width: 40.w, height: 12.h),
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
