import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/themes/app_theme.dart';
import 'package:handy/config/routes/app_pages.dart';
import 'package:handy/modules/events/controllers/events_controller.dart';
import 'package:handy/core/widgets/cards/event_card.dart';
import 'package:handy/core/widgets/custom_gradient_header.dart';
import 'package:handy/core/widgets/shimmers/shimmer_helper.dart';
import 'package:handy/core/widgets/shimmers/event_card_shimmer.dart';

class EventsView extends GetView<EventsController> {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is initialized
    Get.put(EventsController());

    return Scaffold(
      body: RefreshIndicator(
        color: AppTheme.primaryColor,
        onRefresh: controller.refreshEvents,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: controller.scrollController,
          child: Column(
            children: [
              CustomGradientHeader(
                title: 'Events',
                trailingWidget: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.EVENTS_HISTORY);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.warningColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'History',
                      style: TextStyle(
                        color: AppTheme.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              _buildCategoryFilters(),
              SafeArea(
                top: false,
                child: Obx(() {
                  if (controller.isFirstLoad.value) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 20.h,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) => const EventCardShimmer(),
                    );
                  }

                  if (controller.allEvents.isEmpty) {
                    return Container(
                      height: 400.h,
                      alignment: Alignment.center,
                      child: Text(
                        'No upcoming events found',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.white
                              : AppTheme.black,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    itemCount:
                        controller.allEvents.length +
                        (controller.isLoadMore.value ? 1 : 0),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 20.h),
                    itemBuilder: (context, index) {
                      if (index == controller.allEvents.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        );
                      }
                      final event = controller.allEvents[index];
                      return EventCard(event: event);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Obx(() {
        if (controller.isCategoriesLoading.value) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (context, index) => SizedBox(width: 10.w),
            itemBuilder: (context, index) => ShimmerHelper(
              child: ShimmerContainer(
                width: 80.w,
                height: 40.h,
                borderRadius: 20.r,
              ),
            ),
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
              final isSelected =
                  controller.selectedCategory.value?.id == category.id;
              return GestureDetector(
                onTap: () => controller.selectCategory(category),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                  alignment: Alignment.center,
                  child: Text(
                    category.label,
                    style: TextStyle(
                      color: isSelected
                          ? AppTheme.white
                          : AppTheme.white.withValues(alpha: 0.7),
                      fontSize: 14.sp,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
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
}
