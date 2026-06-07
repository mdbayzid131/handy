import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/routes/app_pages.dart';
import 'package:handy/config/themes/app_theme.dart';
import '../../../core/widgets/custom_gradient_header.dart';
import '../controllers/sermons_controller.dart';
import '../../../data/models/sermons_model.dart';

class SermonsView extends GetView<SermonsController> {
  const SermonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          SizedBox(height: 20.h),
          _buildSearchBar(),
          SizedBox(height: 20.h),
          _buildCategories(),
          SizedBox(height: 16.h),
          Expanded(
            child: Obx(
              () => ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                itemCount: controller.filteredSermons.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final sermon = controller.filteredSermons[index];
                  return _buildSermonCard(sermon);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return CustomGradientHeader(
      title: 'Sermons',
      showBackButton: false,
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        height: 50.h,
        decoration: BoxDecoration(
          color: AppTheme.containerColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppTheme.secondaryColor, width: 1),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: AppTheme.white.withValues(alpha: 0.5),
              size: 24.w,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: TextField(
                onChanged: controller.updateSearchQuery,
                style: TextStyle(color: AppTheme.white, fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: 'Search sermons...',
                  hintStyle: TextStyle(
                    color: AppTheme.white.withValues(alpha: 0.5),
                    fontSize: 14.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          return Obx(() {
            final isSelected = controller.selectedCategory.value == category;
            return GestureDetector(
              onTap: () => controller.selectCategory(category),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primaryColor
                      : AppTheme.containerColor,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : AppTheme.secondaryColor,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected
                          ? AppTheme.white
                          : AppTheme.white.withValues(alpha: 0.6),
                      fontSize: 14.sp,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildSermonCard(Sermon sermon) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.SERMON_DITAILS, arguments: sermon);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppTheme.containerColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppTheme.secondaryColor, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                color: AppTheme.warningColor,
                size: 40.w,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sermon.category,
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    sermon.title,
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    sermon.pastor,
                    style: TextStyle(
                      color: AppTheme.white.withValues(alpha: 0.6),
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        sermon.date,
                        style: TextStyle(
                          color: AppTheme.white.withValues(alpha: 0.5),
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        sermon.duration,
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
