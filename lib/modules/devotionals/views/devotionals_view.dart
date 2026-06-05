import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/routes/app_pages.dart';

class DevotionalItem {
  final String day;
  final String date;
  final String title;
  final String reference;
  final String preview;

  DevotionalItem(this.day, this.date, this.title, this.reference, this.preview);
}

class DevotionalsView extends StatelessWidget {
  const DevotionalsView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DevotionalItem> devotionalsList = [
      DevotionalItem(
        'MONDAY',
        'May 5, 2025',
        'Still Waters',
        'Psalm 23:2',
        'In the noise and rush of daily life, God\'s invitation is to rest. The She...',
      ),
      DevotionalItem(
        'TUESDAY',
        'May 6, 2025',
        'More Than Enough',
        'John 6:35',
        'Jesus does not offer to supplement our lives — He offers to satisfy the...',
      ),
      DevotionalItem(
        'WEDNESDAY',
        'May 7, 2025',
        'The Gift of Today',
        'Lamentations 3:22–23',
        'Every morning is a fresh page. Yesterday\'s failures do not define ...',
      ),
      DevotionalItem(
        'THURSDAY',
        'May 8, 2025',
        'Courage for the Calling',
        'Joshua 1:9',
        'God did not tell Joshua to feel courageous — He commanded hi...',
      ),
      DevotionalItem(
        'FRIDAY',
        'May 9, 2025',
        'Rooted and Grounded',
        'Ephesians 3:17',
        'A tree survives storms not because of its height but because ...',
      ),
      DevotionalItem(
        'SATURDAY',
        'May 10, 2025',
        'Sabbath Rest',
        'Matthew 11:28',
        'Rest is not laziness — it is trust. When we rest, we declare that the...',
      ),
      DevotionalItem(
        'SUNDAY',
        'May 11, 2025',
        'A Day of Worship',
        'Psalm 100:4',
        'Sunday is a gift — a weekly reminder that we belong to somet...',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarHeight: 110.h,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.w),
          onPressed: () => Get.back(),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF2844B4), // Lighter blue
                Color(0xFF0A123D), // Darker blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Devotionals',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'PIWC Stoneyburn',
              style: TextStyle(
                color: const Color(0xFFFFC107),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Banner Fixed Below AppBar
            Container(
              margin: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 24.h,
                bottom: 24.h,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2340),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFFFC107).withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.wb_sunny,
                    color: const Color(0xFFFFC107),
                    size: 24.w,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Text(
                      'Read today\'s devotional and start your day with God',
                      style: TextStyle(
                        color: const Color(0xFF3B68E7),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 0,
                ), // padding top is handled by banner margin
                itemCount: devotionalsList.length,
                itemBuilder: (context, index) {
                  final item = devotionalsList[index];
                  final isFirstCard = index == 0;

                  return GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.DEVOTIONALS_DETAILS),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: isFirstCard
                            ? const Color(0xFF3B68E7)
                            : const Color(0xFF1A2340),
                        borderRadius: BorderRadius.circular(16.r),
                        border: isFirstCard
                            ? null
                            : Border.all(color: Colors.white.withOpacity(0.05)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 80
                                .w, // increased slightly to fit longer dates right-aligned
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 22.h,
                                ), // Push down to align with reference text
                                Text(
                                  item.day,
                                  style: TextStyle(
                                    color: isFirstCard
                                        ? const Color(0xFFFFC107)
                                        : const Color(0xFF8E99AF),
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  item.date,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: isFirstCard
                                        ? Colors.white
                                        : const Color(0xFF8E99AF),
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  item.reference,
                                  style: TextStyle(
                                    color: isFirstCard
                                        ? const Color(0xFFFFC107)
                                        : const Color(0xFF3B68E7),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  item.preview,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: isFirstCard
                                        ? Colors.white.withOpacity(0.8)
                                        : const Color(0xFF8E99AF),
                                    fontSize: 13.sp,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Padding(
                            padding: EdgeInsets.only(top: 24.h),
                            child: Icon(
                              Icons.chevron_right,
                              color: isFirstCard
                                  ? Colors.white.withOpacity(0.8)
                                  : const Color(0xFF8E99AF),
                              size: 20.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
