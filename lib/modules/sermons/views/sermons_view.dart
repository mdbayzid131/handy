import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/routes/app_pages.dart';
import 'package:handy/modules/sermon_ditails/bindings/sermon_ditails_binding.dart';
import 'package:handy/modules/sermon_ditails/views/sermon_ditails_view.dart';
import '../controllers/sermons_controller.dart';
import '../../../data/models/sermons_model.dart';

class SermonsView extends GetView<SermonsController> {
  const SermonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B101E),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: _buildHeader(context),
      ),
      body: Column(
        children: [
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
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16.h,
        left: 20.w,
        right: 20.w,
        bottom: 16.h,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF132488), // Deep blue at top
            Color(0xFF091244), // Darker blue at bottom
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Sermons',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'PIWC Stoneyburn',
            style: TextStyle(
              color: const Color(0xFFFFC107),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        height: 50.h,
        decoration: BoxDecoration(
          color: const Color(0xFF1B233D),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.white.withOpacity(0.5),
              size: 24.w,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: TextField(
                onChanged: controller.updateSearchQuery,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: 'Search sermons...',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
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
                      ? const Color(0xFF1E37AB)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withOpacity(0.6),
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
          color: const Color(0xFF1B233D),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1A3BB6),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                color: const Color(0xFFFFC107),
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
                      color: const Color(0xFF3B68E7),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    sermon.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    sermon.pastor,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
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
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        sermon.duration,
                        style: TextStyle(
                          color: const Color(0xFF3B68E7),
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
