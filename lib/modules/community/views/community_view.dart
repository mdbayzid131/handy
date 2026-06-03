import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunityItem {
  final String category;
  final String title;
  final String description;
  final String date;

  CommunityItem(this.category, this.title, this.description, this.date);
}

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CommunityItem> communityItems = [
      CommunityItem(
        'FINANCE',
        'Building Fund Update',
        'We\'ve reached 68% of our building fund goal! Thank you for your generous giving. Together, we\'re building a home for the next generation.',
        'May 1, 2026',
      ),
      CommunityItem(
        'YOUTH',
        'Youth Night: Ignite — This Friday',
        'All teens and young adults (13–25) are invited to Ignite this Friday at 6:30 PM. Worship, games, and a powerful word. Bring your friends!',
        'Apr 30, 2026',
      ),
      CommunityItem(
        'WOMEN',
        'Women\'s Ministry Prayer Breakfast',
        'Join us for our monthly prayer breakfast. It will be a time of refreshing, fellowship, and deep prayers. Breakfast will be provided.',
        'Apr 28, 2026',
      ),
      CommunityItem(
        'MEN',
        'Men of Valor Conference 2026',
        'Registration is now open for the annual Men of Valor conference. Early bird tickets are available at the information desk.',
        'Apr 25, 2026',
      ),
      CommunityItem(
        'CHOIR',
        'Choir Rehearsal Schedule Change',
        'Please note that this week\'s choir rehearsal has been moved to Thursday at 7:00 PM instead of Wednesday. Please be on time.',
        'Apr 22, 2026',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
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
              'Community',
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
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        itemCount: communityItems.length,
        itemBuilder: (context, index) {
          final item = communityItems[index];
          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1A2340),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B68E7).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    item.category,
                    style: TextStyle(
                      color: const Color(0xFF476BFF),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  item.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  item.description,
                  style: TextStyle(
                    color: const Color(0xFF8E99AF),
                    fontSize: 14.sp,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  item.date,
                  style: TextStyle(
                    color: const Color(0xFF8E99AF),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
