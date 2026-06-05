import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/routes/app_pages.dart';
import 'package:handy/config/themes/app_theme.dart';
import 'package:handy/config/constants/image_paths.dart';
import '../controllers/news_controller.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarHeight: 120.h,
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
                        color: AppTheme.warningColor, // Yellow
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.NOTIFICATION);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.notifications,
                      color: AppTheme.warningColor,
                      size: 24.w,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        titleSpacing: 20.w,
      ),
      body: SafeArea(top: false, child: _buildAnnouncementsList()),
    );
  }

  Widget _buildAnnouncementsList() {
    final List<Map<String, dynamic>> newsData = [
      {
        'type': 'megaphone',
        'title':
            'Sunday Service · 10:00 AM – 12:30 PM · 71 Stoneyburn Street, EH47 8JT',
        'color': AppTheme.warningColor,
      },
      {
        'type': 'regular',
        'isPinned': true,
        'title': 'Sunday Service — This Week',
        'tag': 'Service',
        'tagColor': const Color(0xFF3B68E7),
        'borderColor': AppTheme.warningColor,
        'description':
            'Join us this Sunday at 71 Stoneyburn Street. Service runs from 10:00 AM to 12:30 PM. All are ...',
        'date': 'May 5, 2026',
        'imageUrl': ImagePaths.service1,
      },
      {
        'type': 'regular',
        'isPinned': false,
        'title': 'Baptism Sunday — Register Now',
        'tag': 'Milestone',
        'tagColor': const Color(0xFF00BFA5),
        'borderColor': const Color(0xFF00BFA5),
        'description':
            'If you\'re ready to take the step of water baptism, please speak with any of our elders or pastors. Ba...',
        'date': 'May 4, 2026',
        'imageUrl': ImagePaths.service1,
      },
      {
        'type': 'regular',
        'isPinned': false,
        'title': 'Volunteer Opportunities Open',
        'tag': 'Serve',
        'tagColor': const Color(0xFFFF5722),
        'borderColor': const Color(0xFFFF5722),
        'description':
            'We have openings in Ushering, Children\'s Ministry, Media Team, and Hospitality. If you\'d like to serve,...',
        'date': 'May 3, 2026',
        'imageUrl': ImagePaths.service1,
      },
    ];

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
          return Obx(() {
            final isExpanded = controller.expandedIndex.value == index;
            return GestureDetector(
              onTap: () => controller.toggleExpanded(index),
              child: _buildNewsCard(
                isPinned: item['isPinned'] as bool,
                title: item['title'] as String,
                tag: item['tag'] as String,
                tagColor: item['tagColor'] as Color,
                borderColor: item['borderColor'] as Color,
                description: item['description'] as String,
                date: item['date'] as String,
                isExpanded: isExpanded,
                imageUrl: item['imageUrl'] as String?,
              ),
            );
          });
        }
      },
    );
  }

  Widget _buildMegaphoneCard({required String text, required Color color}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppTheme.containerColor, // Slightly lighter than background
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppTheme.secondaryColor, width: 1),
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
    required bool isExpanded,
    String? imageUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.containerColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppTheme.secondaryColor, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                                    color: AppTheme.warningColor,
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
                              color: tagColor.withOpacity(0.15),
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
                          color: Colors.white.withOpacity(0.6),
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
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            isExpanded ? 'Hide flier' : 'Tap for flier',
                            style: TextStyle(
                              color: const Color(0xFF3B68E7),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      if (isExpanded && imageUrl != null) ...[
                        SizedBox(height: 16.h),
                        Container(
                          height: 350.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            image: DecorationImage(
                              image: AssetImage(imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
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
}
