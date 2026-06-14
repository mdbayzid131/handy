import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/bible_chapter_controller.dart';
import 'package:handy/config/themes/app_theme.dart';

class BibleChaptersView extends GetView<BibleChapterController> {
  const BibleChaptersView({super.key});

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
            controller.bookName.value,
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
        child: RefreshIndicator(
          onRefresh: controller.refreshData,
          color: AppTheme.primaryColor,
          child: Obx(() {
            if (controller.isLoading.value && controller.chaptersList.isEmpty) {
              return const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor));
            }

            final chapters = controller.chaptersList;
            if (chapters.isEmpty && !controller.isLoading.value) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  alignment: Alignment.center,
                  child: Text(
                    'No chapters found',
                    style: TextStyle(color: AppTheme.mutedTextColor, fontSize: 16.sp),
                  ),
                ),
              );
            }

            final chaptersCount = chapters.length;
            final fullRows = (chaptersCount / 5).floor();
            final remainder = chaptersCount % 5;
            final totalRows = fullRows + (remainder > 0 ? 1 : 0);

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.bookName.value,
                          style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppTheme.white
                                : AppTheme.black,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '$chaptersCount chapters',
                          style: TextStyle(
                            color: AppTheme.mutedTextColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 8.h,
                    ),
                    itemCount: totalRows,
                    itemBuilder: (context, rowIndex) {
                      int itemsInRow = (rowIndex < fullRows) ? 5 : remainder;

                      List<Widget> rowChildren = [];
                      for (int i = 0; i < itemsInRow; i++) {
                        int chapterIndex = rowIndex * 5 + i;
                        String chapter = chapters[chapterIndex];
                        rowChildren.add(
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 0.9,
                              child: _buildChapterBox(chapter),
                            ),
                          ),
                        );
                        if (i < itemsInRow - 1) {
                          rowChildren.add(SizedBox(width: 12.w));
                        }
                      }

                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Row(children: rowChildren),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildChapterBox(String chapter) {
    final isSelected = controller.selectedChapter.value == chapter;
    return GestureDetector(
      onTap: () => controller.onChapterSelected(chapter),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.accentBlue : AppTheme.containerColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppTheme.secondaryColor,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          chapter,
          style: TextStyle(
            color: AppTheme.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
