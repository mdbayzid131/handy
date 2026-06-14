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
          'Bible',
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
                ? AppTheme.secondaryColor
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
                      color: AppTheme.containerColor,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppTheme.secondaryColor),
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

                  // Bible Version Dropdown
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.containerColor,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppTheme.secondaryColor),
                    ),
                    child: Obx(
                      () => PopupMenuButton<String>(
                        onSelected: (String result) {
                          controller.updateVersion(result);
                        },
                        color: AppTheme.containerColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          side: BorderSide(color: AppTheme.secondaryColor),
                        ),
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width - 40.w,
                          maxWidth: MediaQuery.of(context).size.width - 40.w,
                        ),
                        offset: Offset(0, 60.h),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                              for (var version in controller.versions)
                                PopupMenuItem<String>(
                                  value: version.abbreviation ?? '',
                                  child: Center(
                                    child: Text(
                                      version.name ?? '', // Dropdown shows full name
                                      style: TextStyle(
                                        color: AppTheme.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.versions.firstWhereOrNull((v) => v.abbreviation == controller.selectedVersionKey.value)?.name ??
                                    '',
                                style: TextStyle(
                                  color: AppTheme.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: AppTheme.mutedTextColor,
                                size: 24.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value && controller.versions.isEmpty) {
                  return const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor));
                }

                final books = controller.filteredBooks;

                if (books.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: controller.refreshData,
                    color: AppTheme.primaryColor,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        alignment: Alignment.center,
                        child: Text(
                          'No books found',
                          style: TextStyle(
                            color: AppTheme.mutedTextColor,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                }

                final rowCount = (books.length / 2).ceil();

                return RefreshIndicator(
                  onRefresh: controller.refreshData,
                  color: AppTheme.primaryColor,
                  child: ListView.builder(
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
                          Expanded(
                            child: _buildBookCard(context, books[firstIndex]),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: _buildBookCard(context, books[secondIndex]),
                          ),
                        ],
                      ),
                    );
                  },
                ),
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
      onTap: () {
        final controller = Get.find<BibleController>();
        final versionId = controller.versions.firstWhereOrNull((v) => v.abbreviation == controller.selectedVersionKey.value)?.id ?? 1;
        Get.toNamed(
          AppRoutes.BIBLE_CHAPTERS,
          arguments: {
            'bookId': book.id ?? '',
            'name': book.name ?? '',
            'versionId': versionId,
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: AppTheme.containerColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppTheme.secondaryColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.name ?? '',
              style: TextStyle(
                color: Colors.white,
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
