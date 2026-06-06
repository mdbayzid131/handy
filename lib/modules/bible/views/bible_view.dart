import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/routes/app_pages.dart';
import '../../../data/models/bible_model.dart';
import '../controllers/bible_controller.dart';
import 'package:handy/config/themes/app_theme.dart';

class BibleView extends GetView<BibleController> {
  const BibleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white
                : AppTheme.black,
            size: 24.w,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Bible',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white
                : AppTheme.black,
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.cardColor,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppTheme.white.withValues(alpha: 0.05),
                      ),
                    ),
                    child: TextField(
                      onChanged: controller.updateSearchQuery,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.white
                            : AppTheme.black,
                        fontSize: 16.sp,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppTheme.mutedTextColor,
                          size: 24.w,
                        ),
                        hintText: 'Search books...',
                        hintStyle: TextStyle(
                          color: AppTheme.mutedTextColor,
                          fontSize: 16.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Toggle Buttons
                  Obx(
                    () => Container(
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppTheme.white.withValues(alpha: 0.05),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => controller.toggleTestament(true),
                              child: Container(
                                margin: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  color: controller.isOldTestament.value
                                      ? AppTheme.accentBlue
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Old Testament',
                                  style: TextStyle(
                                    color: controller.isOldTestament.value
                                        ? AppTheme.white
                                        : AppTheme.mutedTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => controller.toggleTestament(false),
                              child: Container(
                                margin: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  color: !controller.isOldTestament.value
                                      ? AppTheme.accentBlue
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'New Testament',
                                  style: TextStyle(
                                    color: !controller.isOldTestament.value
                                        ? AppTheme.white
                                        : AppTheme.mutedTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Obx(() {
                final books = controller.filteredBooks;

                if (books.isEmpty) {
                  return Center(
                    child: Text(
                      'No books found',
                      style: TextStyle(
                        color: AppTheme.mutedTextColor,
                        fontSize: 16.sp,
                      ),
                    ),
                  );
                }

                final rowCount = (books.length / 2).ceil();

                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 4.h,
                  ),
                  itemCount: rowCount,
                  itemBuilder: (context, index) {
                    final firstIndex = index * 2;
                    final secondIndex = firstIndex + 1;
                    final hasSecond = secondIndex < books.length;

                    if (!hasSecond) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: _buildBookCard(context, books[firstIndex]),
                      );
                    }

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Row(
                        children: [
                          Expanded(child: _buildBookCard(context, books[firstIndex])),
                          SizedBox(width: 16.w),
                          Expanded(child: _buildBookCard(context, books[secondIndex])),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookCard(BuildContext context, BibleBook book) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.BIBLE_CHAPTERS,
        arguments: {'name': book.name, 'chaptersCount': book.chaptersCount},
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppTheme.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.name,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.white
                    : AppTheme.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              '${book.chaptersCount} ch.',
              style: TextStyle(color: AppTheme.mutedTextColor, fontSize: 13.sp),
            ),
          ],
        ),
      ),
    );
  }
}
