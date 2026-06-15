import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'shimmer_helper.dart';

class ListShimmer extends StatelessWidget {
  final int itemCount;

  const ListShimmer({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: ShimmerHelper(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerContainer(
                  width: 50.w,
                  height: 50.w,
                  shape: BoxShape.circle,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerContainer(width: double.infinity, height: 14.h),
                      SizedBox(height: 8.h),
                      ShimmerContainer(width: 200.w, height: 14.h),
                      SizedBox(height: 8.h),
                      ShimmerContainer(width: 100.w, height: 14.h),
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
}
