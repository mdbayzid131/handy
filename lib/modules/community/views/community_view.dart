import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/themes/app_theme.dart';
import 'package:handy/core/widgets/custom_gradient_header.dart';

import '../controllers/community_controller.dart';
import 'package:get/get.dart';
import '../../../core/widgets/shimmers/shimmer_helper.dart';
import 'package:handy/core/utils/helpers.dart';

class CommunityView extends GetView<CommunityController> {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomGradientHeader(
            title: 'Community',
            subtitle: 'PIWC Stoneyburn',
            showBackButton: true,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.refreshData,
              color: AppTheme.primaryColor,
              child: Obx(() {
                if (controller.isLoading.value &&
                    controller.communityList.isEmpty) {
                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ShimmerContainer(width: 52.w, height: 52.w, borderRadius: 12.r),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ShimmerContainer(width: 150.w, height: 14.h),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              ShimmerContainer(width: double.infinity, height: 14.h),
                              SizedBox(height: 4.h),
                              ShimmerContainer(width: 200.w, height: 14.h),
                              SizedBox(height: 20.h),
                              ShimmerContainer(width: double.infinity, height: 48.h, borderRadius: 24.r),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                if (controller.communityList.isEmpty) {
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(height: 100.h),
                      Center(
                        child: Text(
                          'No community groups found',
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
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 24.h,
                  ),
                  itemCount: controller.communityList.length,
                  itemBuilder: (context, index) {
                    final item = controller.communityList[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: AppTheme.containerColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppTheme.secondaryColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF1E294A,
                                  ), // Background for icon
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  Icons.groups,
                                  color: AppTheme.royalBlue,
                                  size: 28.w,
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
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            item.description ?? '',
                            style: TextStyle(
                              color: AppTheme.mutedTextColor,
                              fontSize: 14.sp,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.royalBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 14.h,
                                ),
                              ),
                              onPressed: () => controller.joinCommunity(item.joinLink),
                              child: Text(
                                'Join',
                                style: TextStyle(
                                  color: AppTheme.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
