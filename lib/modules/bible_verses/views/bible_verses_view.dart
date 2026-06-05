import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/bible_verses_controller.dart';

class BibleVersesView extends GetView<BibleVersesController> {
  const BibleVersesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
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
            '${controller.bookName.value} ${controller.chapter.value}',
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
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
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
                            color: Colors.white,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }

                    final verseIndex = index - 1;
                    final verseNumber = verseIndex + 1;
                    final verseText = controller.verses[verseIndex];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 32.w,
                            child: Text(
                              '$verseNumber',
                              style: TextStyle(
                                color: const Color(0xFF3B68E7),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              verseText,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 17.sp,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),

            // Bottom Navigation
            Obx(() {
              final chapter = controller.chapter.value;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  border: Border(
                    top: BorderSide(color: Colors.white.withOpacity(0.05)),
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
          color: const Color(0xFF1A2340),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isNext) Icon(icon, color: const Color(0xFF3B68E7), size: 20.w),
            if (!isNext) SizedBox(width: 4.w),
            Text(
              text,
              style: TextStyle(
                color: const Color(0xFF3B68E7),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isNext) SizedBox(width: 4.w),
            if (isNext) Icon(icon, color: const Color(0xFF3B68E7), size: 20.w),
          ],
        ),
      ),
    );
  }
}
