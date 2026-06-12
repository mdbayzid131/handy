import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/routes/app_pages.dart';
import '../controllers/events_history_controller.dart';
import '../../../data/models/events_model.dart';
import 'package:handy/config/themes/app_theme.dart';
import 'package:handy/core/widgets/custom_gradient_header.dart';

class EventsHistoryView extends GetView<EventsHistoryController> {
  const EventsHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomGradientHeader(
            title: 'Events History',
            subtitle: 'PIWC Stoneyburn',
            showBackButton: true,
          ),
          _buildCategoryFilters(),
          Expanded(
            child: SafeArea(
              top: false,
              child: RefreshIndicator(
                color: AppTheme.primaryColor,
                backgroundColor: AppTheme.containerColor,
                onRefresh: controller.refreshEvents,
                child: Obx(() {
                  if (controller.isFirstLoad.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppTheme.primaryColor),
                    );
                  }

                  if (controller.allEvents.isEmpty) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Container(
                        height: 400.h,
                        alignment: Alignment.center,
                        child: Text(
                          'No history events found',
                          style: TextStyle(color: AppTheme.white.withValues(alpha: 0.5)),
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    controller: controller.scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    itemCount: controller.allEvents.length + (controller.isLoadMore.value ? 1 : 0),
                    separatorBuilder: (context, index) => SizedBox(height: 20.h),
                    itemBuilder: (context, index) {
                      if (index == controller.allEvents.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(color: AppTheme.primaryColor),
                          ),
                        );
                      }
                      final event = controller.allEvents[index];
                      return _buildEventCard(event);
                    },
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Obx(() {
        if (controller.isCategoriesLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.primaryColor),
          );
        }
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          separatorBuilder: (context, index) => SizedBox(width: 10.w),
          itemBuilder: (context, index) {
            final category = controller.categories[index];

            return Obx(() {
              final isSelected = controller.selectedCategory.value?.id == category.id;
              return GestureDetector(
                onTap: () => controller.selectCategory(category),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF132488)
                        : AppTheme.containerColor,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.accentBlue
                          : AppTheme.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    category.label,
                    style: TextStyle(
                      color: isSelected
                          ? AppTheme.white
                          : AppTheme.white.withValues(alpha: 0.7),
                      fontSize: 14.sp,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              );
            });
          },
        );
      }),
    );
  }

  Color _getCategoryColor(String? colorHex) {
    if (colorHex == null || colorHex.isEmpty) {
      return const Color(0xFF132488);
    }
    try {
      String hex = colorHex.toUpperCase().replaceAll("#", "");
      if (hex.length == 6) {
        hex = "FF$hex";
      }
      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      return const Color(0xFF132488);
    }
  }

  Widget _buildEventCard(EventModel event) {
    final headerColor = _getCategoryColor(event.categoryColor);

    return GestureDetector(
      onTap: () =>
          Get.toNamed(AppRoutes.EVENTS_HISTORY_DETAILS, arguments: event),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.containerColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppTheme.secondaryColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Colored Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: headerColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: AppTheme.white, size: 16.w),
                  SizedBox(width: 8.w),
                  Text(
                    event.categoryLabel.toUpperCase(),
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            // Event Details
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: AppTheme.white.withValues(alpha: 0.5),
                        size: 14.w,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${event.date} · ${event.time}',
                        style: TextStyle(
                          color: AppTheme.white.withValues(alpha: 0.6),
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppTheme.white.withValues(alpha: 0.5),
                        size: 14.w,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          event.location,
                          style: TextStyle(
                            color: AppTheme.white.withValues(alpha: 0.6),
                            fontSize: 13.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryColor,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          '${event.attendingCount} attended',
                          style: TextStyle(
                            color: headerColor.withValues(alpha: 0.9),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: headerColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'View',
                          style: TextStyle(
                            color: AppTheme.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
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
