import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/news_controller.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Dark navy background
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SafeArea(
              top: false,
              child: Obx(() {
                if (controller.currentIndex.value == 0) {
                  return _buildAnnouncementsList();
                } else {
                  return _buildEventFliersList();
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF132488), // Deep blue at top
            Color(0xFF091244), // Darker blue at bottom
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            bottom: 12.h,
            top: 10.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Announcements',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'PIWC Stoneyburn',
                        style: TextStyle(
                          color: const Color(0xFFFFC107), // Yellow
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      // Get.toNamed(Routes.notifications);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.notifications,
                        color: const Color(0xFFFFC107),
                        size: 24.w,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              // Toggle Tabs
              Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.currentIndex.value = 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.currentIndex.value == 0
                                  ? const Color(0xFFFFC107)
                                  : const Color(0xFF283259), // Dark blue/grey
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: Center(
                              child: Text(
                                'Announcements',
                                style: TextStyle(
                                  color: controller.currentIndex.value == 0
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.currentIndex.value = 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.currentIndex.value == 1
                                  ? const Color(0xFFFFC107)
                                  : const Color(0xFF283259), // Dark blue/grey
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: Center(
                              child: Text(
                                'Event Fliers',
                                style: TextStyle(
                                  color: controller.currentIndex.value == 1
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
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
      ),
    );
  }

  Widget _buildAnnouncementsList() {
    final List<Map<String, dynamic>> newsData = [
      {
        'type': 'megaphone',
        'title':
            'Sunday Service · 10:00 AM – 12:30 PM · 71 Stoneyburn Street, EH47 8JT',
        'color': const Color(0xFFFFC107),
      },
      {
        'type': 'regular',
        'isPinned': true,
        'title': 'Sunday Service — This Week',
        'tag': 'Service',
        'tagColor': const Color(0xFF3B68E7), // Blue
        'borderColor': const Color(0xFFFFC107), // Yellow
        'description':
            'Join us this Sunday at 71 Stoneyburn Street. Service runs from 10:00 AM to 12:30 PM. All are ...',
        'date': 'May 5, 2026',
      },
      {
        'type': 'regular',
        'isPinned': false,
        'title': 'Baptism Sunday — Register Now',
        'tag': 'Milestone',
        'tagColor': const Color(0xFF00BFA5), // Green
        'borderColor': const Color(0xFF00BFA5), // Green
        'description':
            'If you\'re ready to take the step of water baptism, please speak with any of our elders or pastors. Ba...',
        'date': 'May 4, 2026',
      },
      {
        'type': 'regular',
        'isPinned': false,
        'title': 'Volunteer Opportunities Open',
        'tag': 'Serve',
        'tagColor': const Color(0xFFFF5722), // Orange
        'borderColor': const Color(0xFFFF5722), // Orange
        'description':
            'We have openings in Ushering, Children\'s Ministry, Media Team, and Hospitality. If you\'d like to serve,...',
        'date': 'May 3, 2026',
      },
    ];

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      itemCount: newsData.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final item = newsData[index];
        if (item['type'] == 'megaphone') {
          return _buildMegaphoneCard(
            text: item['title'] as String,
            color: item['color'] as Color,
          );
        } else {
          return _buildNewsCard(
            isPinned: item['isPinned'] as bool,
            title: item['title'] as String,
            tag: item['tag'] as String,
            tagColor: item['tagColor'] as Color,
            borderColor: item['borderColor'] as Color,
            description: item['description'] as String,
            date: item['date'] as String,
          );
        }
      },
    );
  }

  Widget _buildMegaphoneCard({required String text, required Color color}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2336), // Slightly lighter than background
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.campaign_rounded, color: color, size: 24.w),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: const Color(0xFF3B68E7), // Distinct blue text
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard({
    required bool isPinned,
    required String title,
    required String tag,
    required Color tagColor,
    required Color borderColor,
    required String description,
    required String date,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2336),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor.withValues(alpha: 0.3), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          15.r,
        ), // slightly less than container to fit inside border
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Thick left border
              Container(width: 4.w, color: borderColor),
              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isPinned) ...[
                                  Icon(
                                    Icons.push_pin,
                                    color: const Color(0xFFFFC107),
                                    size: 16.w,
                                  ),
                                  SizedBox(width: 8.w),
                                ],
                                Expanded(
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: tagColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                color: tagColor,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 14.sp,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            date,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            'Read more',
                            style: TextStyle(
                              color: const Color(0xFF3B68E7),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventFliersList() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      children: [
        _buildFlierCard(
          imageUrl:
              'https://images.unsplash.com/photo-1438232992991-995b7058bbb3',
          label: 'WEEKLY',
        ),
        SizedBox(height: 20.h),
        _buildFlierCard(
          imageUrl: 'https://images.unsplash.com/photo-1544427920-c49ccfb85579',
          label: 'YOUTH',
        ),
      ],
    );
  }

  Widget _buildFlierCard({required String imageUrl, required String label}) {
    return Stack(
      children: [
        Container(
          height: 350.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // NEXT EVENT Badge
        Positioned(
          top: 16.h,
          left: 16.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFD32F2F), // Red badge
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'NEXT EVENT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Label Badge
        Positioned(
          top: 16.h,
          right: 16.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
