import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/themes/app_theme.dart';
import '../../../core/widgets/custom_gradient_header.dart';
import '../../../core/widgets/cards/sermon_card_widget.dart';
import '../controllers/sermons_controller.dart';

class SermonsView extends GetView<SermonsController> {
  const SermonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: controller.refreshData,
        color: AppTheme.primaryColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: controller.scrollController,
          child: Column(
            children: [
              _buildHeader(context),
              SizedBox(height: 16.h),
              _buildSearchBar(),
              SizedBox(height: 16.h),
              _buildCategories(),
              SizedBox(height: 16.h),
              Obx(() {
                if (controller.isFirstLoad.value) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }

                if (controller.filteredSermons.isEmpty) {
                  return Container(
                    height: 400.h,
                    alignment: Alignment.center,
                    child: Text(
                      'No sermons found.',
                      style: TextStyle(color: AppTheme.white, fontSize: 16.sp),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  itemCount:
                      controller.filteredSermons.length +
                      (controller.isLoadMore.value ? 1 : 0),
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    if (index == controller.filteredSermons.length) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }

                    final sermon = controller.filteredSermons[index];
                    return SermonCardWidget(sermon: sermon);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return CustomGradientHeader(title: 'Sermons', showBackButton: false);
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextField(
        onChanged: controller.updateSearchQuery,
        style: TextStyle(color: AppTheme.white, fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: 'Search sermons...',
          hintStyle: TextStyle(
            color: AppTheme.white.withValues(alpha: 0.5),
            fontSize: 14.sp,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppTheme.white.withValues(alpha: 0.5),
            size: 20.w,
          ),
          filled: true,
          fillColor: AppTheme.containerColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppTheme.secondaryColor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppTheme.secondaryColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppTheme.primaryColor, width: 1),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 16.w,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Obx(() {
      if (controller.isCategoriesLoading.value &&
          controller.categories.isEmpty) {
        return SizedBox(
          height: 36.h,
          child: const Center(child: CircularProgressIndicator()),
        );
      }

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
              final isSelected =
                  controller.selectedCategoryId.value == category.id;
              return GestureDetector(
                onTap: () => controller.selectCategory(category.id ?? 'All'),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 4.h,
                  ),
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
                      category.name ?? 'Unknown',
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
    });
  }
}
