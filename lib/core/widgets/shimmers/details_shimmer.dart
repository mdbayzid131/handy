import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'shimmer_helper.dart';

class DetailsShimmer extends StatelessWidget {
  const DetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: ShimmerHelper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image/Banner Placeholder
            ShimmerContainer(
              width: double.infinity,
              height: 250.h,
              borderRadius: 0, // usually details image goes edge to edge
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Placeholder
                  ShimmerContainer(width: 250.w, height: 24.h),
                  SizedBox(height: 16.h),
                  // Subtitle / Date Placeholder
                  Row(
                    children: [
                      ShimmerContainer(width: 100.w, height: 14.h),
                      SizedBox(width: 16.w),
                      ShimmerContainer(width: 80.w, height: 14.h),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  // Content / Paragraph Placeholders
                  ShimmerContainer(width: double.infinity, height: 14.h),
                  SizedBox(height: 8.h),
                  ShimmerContainer(width: double.infinity, height: 14.h),
                  SizedBox(height: 8.h),
                  ShimmerContainer(width: double.infinity, height: 14.h),
                  SizedBox(height: 8.h),
                  ShimmerContainer(width: 200.w, height: 14.h),
                  SizedBox(height: 24.h),
                  ShimmerContainer(width: double.infinity, height: 14.h),
                  SizedBox(height: 8.h),
                  ShimmerContainer(width: double.infinity, height: 14.h),
                  SizedBox(height: 8.h),
                  ShimmerContainer(width: 150.w, height: 14.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
