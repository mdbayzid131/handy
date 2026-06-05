import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/bible_chapter_controller.dart';

class BibleChaptersView extends GetView<BibleChapterController> {
  const BibleChaptersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0F172A),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.w),
          onPressed: () => Get.back(),
        ),
        title: Obx(
          () => Text(
            controller.bookName.value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(color: Colors.white.withOpacity(0.05), height: 1.h),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          final chaptersCount = controller.chaptersCount.value;
          final fullRows = (chaptersCount / 5).floor();
          final remainder = chaptersCount % 5;
          final totalRows = fullRows + (remainder > 0 ? 1 : 0);

          return Column(
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
                        color: Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '$chaptersCount chapters',
                      style: TextStyle(
                        color: const Color(0xFF8E99AF),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 8.h,
                  ),
                  itemCount: totalRows,
                  itemBuilder: (context, rowIndex) {
                    int itemsInRow = (rowIndex < fullRows) ? 5 : remainder;

                    List<Widget> rowChildren = [];
                    for (int i = 0; i < itemsInRow; i++) {
                      int chapter = rowIndex * 5 + i + 1;
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
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildChapterBox(int chapter) {
    final isSelected = controller.selectedChapter.value == chapter;
    return GestureDetector(
      onTap: () => controller.onChapterSelected(chapter),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B68E7) : const Color(0xFF1A2340),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Colors.white.withOpacity(0.05),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          '$chapter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
