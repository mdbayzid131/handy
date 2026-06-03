import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/routes/app_pages.dart';
import '../../../data/models/bible_model.dart';
import '../controllers/bible_controller.dart';

class BibleView extends GetView<BibleController> {
  const BibleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0F172A),
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
          child: Container(color: Colors.white.withOpacity(0.05), height: 1.h),
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
                      color: const Color(0xFF1A2340),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: TextField(
                      onChanged: controller.updateSearchQuery,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: const Color(0xFF8E99AF),
                          size: 24.w,
                        ),
                        hintText: 'Search books...',
                        hintStyle: TextStyle(
                          color: const Color(0xFF8E99AF),
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
                        color: const Color(0xFF1A2340),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.05),
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
                                      ? const Color(0xFF3B68E7)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Old Testament',
                                  style: TextStyle(
                                    color: controller.isOldTestament.value
                                        ? Colors.white
                                        : const Color(0xFF8E99AF),
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
                                      ? const Color(0xFF3B68E7)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'New Testament',
                                  style: TextStyle(
                                    color: !controller.isOldTestament.value
                                        ? Colors.white
                                        : const Color(0xFF8E99AF),
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
                        color: const Color(0xFF8E99AF),
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
                        child: _buildBookCard(books[firstIndex]),
                      );
                    }

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Row(
                        children: [
                          Expanded(child: _buildBookCard(books[firstIndex])),
                          SizedBox(width: 16.w),
                          Expanded(child: _buildBookCard(books[secondIndex])),
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

  Widget _buildBookCard(BibleBook book) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.BIBLE_CHAPTERS, arguments: {
        'name': book.name,
        'chaptersCount': book.chaptersCount,
      }),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2340),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              '${book.chaptersCount} ch.',
              style: TextStyle(color: const Color(0xFF8E99AF), fontSize: 13.sp),
            ),
          ],
        ),
      ),
    );
  }
}
