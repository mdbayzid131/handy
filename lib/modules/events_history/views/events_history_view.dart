import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/routes/app_pages.dart';
import '../controllers/events_history_controller.dart';
import 'package:handy/config/themes/app_theme.dart';
import 'package:handy/core/widgets/custom_gradient_header.dart';
import 'package:handy/core/widgets/cards/event_card.dart';

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
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                      ),
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
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppTheme.white.withValues(alpha: 0.5)
                                : AppTheme.black.withValues(alpha: 0.5),
                          ),
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
                      return EventCard(
                        event: event,
                        isPastEvent: true,
                        onTap: () => Get.toNamed(
                          AppRoutes.EVENTS_HISTORY_DETAILS,
                          arguments: event,
                        ),
                      );
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
              final isSelected =
                  controller.selectedCategory.value?.id == category.id;
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
