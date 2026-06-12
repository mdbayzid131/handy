import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/bible_verses_controller.dart';
import 'package:handy/config/themes/app_theme.dart';

class BibleVersesView extends GetView<BibleVersesController> {
  const BibleVersesView({super.key});

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
          icon: Icon(Icons.arrow_back, color: AppTheme.white, size: 24.w),
          onPressed: () => Get.back(),
        ),
        title: Obx(
          () => Text(
            '${controller.bookName.value} ${controller.chapter.value}',
            style: TextStyle(
              color: AppTheme.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(color: AppTheme.secondaryColor, height: 1.h),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value && controller.verses.isEmpty) {
                  return const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor));
                }

                if (controller.verses.isEmpty && !controller.isLoading.value) {
                  return Center(
                    child: Text(
                      'No verses found',
                      style: TextStyle(color: AppTheme.mutedTextColor, fontSize: 16.sp),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: controller.refreshData,
                  color: AppTheme.primaryColor,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 24.h,
                    ),
                    itemCount: controller.verses.length + 1, // +1 for the header
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 24.h),
                          child: Text(
                            '${controller.bookName.value} ${controller.chapter.value}',
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness == Brightness.dark
                                  ? AppTheme.white
                                  : AppTheme.black,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }

                      final verseIndex = index - 1;
                      final verse = controller.verses[verseIndex];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 24.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 32.w,
                              child: Text(
                                verse.verseNumber ?? '${verseIndex + 1}',
                                style: TextStyle(
                                  color: AppTheme.accentBlue,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                verse.text ?? '',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppTheme.white.withValues(alpha: 0.9)
                                      : AppTheme.black.withValues(alpha: 0.9),
                                  fontSize: 17.sp,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
            ),

            // Bottom Navigation
            Obx(() {
              final chapter = controller.chapter.value;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppTheme.slate900,
                  border: Border(
                    top: BorderSide(color: AppTheme.secondaryColor),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (chapter > 1)
                      _buildNavButton(
                        icon: Icons.chevron_left,
                        text: 'Chapter ${chapter - 1}',
                        onTap: controller.previousChapter,
                        isNext: false,
                      )
                    else
                      const SizedBox(),

                    if (chapter < controller.maxChapters.value)
                      _buildNavButton(
                        icon: Icons.chevron_right,
                        text: 'Chapter ${chapter + 1}',
                        onTap: controller.nextChapter,
                        isNext: true,
                      )
                    else
                      const SizedBox(),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required bool isNext,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppTheme.containerColor,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: AppTheme.secondaryColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isNext) Icon(icon, color: AppTheme.accentBlue, size: 20.w),
            if (!isNext) SizedBox(width: 4.w),
            Text(
              text,
              style: TextStyle(
                color: AppTheme.accentBlue,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isNext) SizedBox(width: 4.w),
            if (isNext) Icon(icon, color: AppTheme.accentBlue, size: 20.w),
          ],
        ),
      ),
    );
  }
}
