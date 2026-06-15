import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:handy/config/themes/app_theme.dart';
import '../controllers/history_and_core_values_controller.dart';
import '../../../core/widgets/shimmers/details_shimmer.dart';

class HistoryAndCoreValuesView extends GetView<HistoryAndCoreValuesController> {
  const HistoryAndCoreValuesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.backgroundColor
            : AppTheme.containerColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.w),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'History & Core Values',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white.withValues(alpha: 0.05)
                : AppTheme.black.withValues(alpha: 0.1),
            height: 1.h,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.refreshData,
          color: AppTheme.primaryColor,
          child: Obx(() {
            if (controller.isLoading.value && controller.content.value.isEmpty) {
              return const DetailsShimmer();
            }

            if (controller.content.value.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
                  child: Text(
                    'No history or core values available at the moment.',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.white.withValues(alpha: 0.5)
                          : AppTheme.black.withValues(alpha: 0.5),
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Html(
                data: controller.content.value,
                style: {
                  "body": Style(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.white
                        : AppTheme.black,
                    fontSize: FontSize(16.sp),
                    lineHeight: LineHeight(1.6),
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                  ),
                  "h2": Style(
                    fontSize: FontSize(24.sp),
                    fontWeight: FontWeight.bold,
                    margin: Margins.only(top: 16.h, bottom: 8.h),
                  ),
                  "h3": Style(
                    fontSize: FontSize(20.sp),
                    fontWeight: FontWeight.bold,
                    margin: Margins.only(top: 16.h, bottom: 8.h),
                  ),
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
