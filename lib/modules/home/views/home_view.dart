import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/data/models/home_model.dart';
import '../../../config/constants/image_paths.dart';
import '../../../config/routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../../bottom_nab_bar/controllers/bottom_nab_bar.dart';

class _QuickAccessItem {
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final Gradient gradient;

  _QuickAccessItem({
    required this.onTap,
    required this.icon,
    required this.title,
    required this.gradient,
  });
}

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B101E), // Very dark blue/black
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarHeight: 110.h,
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
          children: [
            Row(
              children: [
                // Logo
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      ImagePaths.appLogo,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.church, size: 24.w, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Titles
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PIWC Stoneyburn',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'The Church of Pentecost - UK',
                        style: TextStyle(
                          color: const Color(0xFFFFC107), // Amber
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Action Icons
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.NOTIFICATION),
                  child: Icon(
                    Icons.notifications,
                    color: const Color(0xFFFFC107),
                    size: 24.w,
                  ),
                ),
                SizedBox(width: 16.w),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.PROFILE),
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFC107),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      color: const Color(0xFF091244),
                      size: 24.w,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.h),
            Text(
              'Welcome, Beloved 🙏',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        titleSpacing: 20.w,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              _buildTodaysVerseCard(controller.homeData.todaysVerse),
              SizedBox(height: 16.h),
              _buildNextServiceCard(controller.homeData.nextService),
              SizedBox(height: 16.h),
              _buildWatchLiveCard(),
              SizedBox(height: 32.h),
              Text(
                'Quick Access',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              _buildQuickAccessGrid(),
              SizedBox(height: 32.h),
              _buildSectionHeader(
                'Latest Sermon',
                onSeeAllTap: () =>
                    Get.find<BottomNavBarController>().changeTab(1),
              ),
              SizedBox(height: 16.h),
              _buildLatestSermonCard(controller.homeData.latestSermon),
              SizedBox(height: 32.h),
              _buildSectionHeader(
                'Announcements',
                onSeeAllTap: () =>
                    Get.find<BottomNavBarController>().changeTab(2),
              ),
              SizedBox(height: 16.h),
              ...controller.homeData.announcements.asMap().entries.map((entry) {
                final index = entry.key;
                final announcement = entry.value;
                return Obx(() {
                  final isExpanded = controller.expandedIndex.value == index;
                  return GestureDetector(
                    onTap: () => controller.toggleExpanded(index),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: _buildAnnouncementCard(announcement, isExpanded),
                    ),
                  );
                });
              }),
              SizedBox(height: 28.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTodaysVerseCard(TodaysVerseModel data) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF2844B4), // Lighter blue
            Color(0xFF142470), // Darker blue
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFFC107),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'TODAY\'S VERSE',
              style: TextStyle(
                color: const Color(0xFF142470),
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            data.verse,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            data.reference,
            style: TextStyle(
              color: const Color(0xFFFFC107),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextServiceCard(NextServiceModel data) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFFFD54F), Color(0xFFFF9800)],
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Icons.access_time_filled,
              color: const Color(0xFF0B101E).withOpacity(0.7),
              size: 26.w,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.label,
                  style: TextStyle(
                    color: const Color(0xFF0B101E).withOpacity(0.6),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  data.title,
                  style: TextStyle(
                    color: const Color(0xFF0B101E),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  data.schedule,
                  style: TextStyle(
                    color: const Color(0xFF0B101E).withOpacity(0.8),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.find<BottomNavBarController>().changeTab(1),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: const Color(0xFF2844B4),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Text(
                'Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWatchLiveCard() {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.WATCH_LIVE),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE53935), Color(0xFFFF5722)],
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 16.w,
                  height: 16.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Watch Live',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Join Sunday service on YouTube or\nFacebook',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12.sp,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16.w),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessGrid() {
    final items = [
      _QuickAccessItem(
        onTap: () =>
            Get.find<BottomNavBarController>().changeTab(1), // Sermons tab
        icon: Icons.video_library_rounded,
        title: 'Sermons',
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4A72FF), Color(0xFF284EE6)],
        ),
      ),
      _QuickAccessItem(
        onTap: () =>
            Get.find<BottomNavBarController>().changeTab(3), // Give tab
        icon: Icons.favorite,
        title: 'Give',
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF6B6B), Color(0xFFFF4747)],
        ),
      ),
      _QuickAccessItem(
        onTap: () => Get.toNamed(AppRoutes.PRAYER_WALL),
        icon: Icons.volunteer_activism,
        title: 'Prayer',
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD088FF), Color(0xFFA64DFF)],
        ),
      ),
      _QuickAccessItem(
        onTap: () =>
            Get.find<BottomNavBarController>().changeTab(4), // Events tab
        icon: Icons.event,
        title: 'Events',
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF66BB6A), Color(0xFF388E3C)],
        ),
      ),
      _QuickAccessItem(
        onTap: () => Get.toNamed(AppRoutes.DEVOTIONALS),
        icon: Icons.menu_book,
        title: 'Devotionals',
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF9800), Color(0xFFF57C00)],
        ),
      ),
      _QuickAccessItem(
        onTap: () => Get.toNamed(AppRoutes.BIBLE),
        icon: Icons.book,
        title: 'Bible',
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF26A69A), Color(0xFF00796B)],
        ),
      ),
      _QuickAccessItem(
        onTap: () => Get.toNamed(AppRoutes.WATCH_LIVE),
        icon: Icons.videocam,
        title: 'Watch Live',
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF7043), Color(0xFFE64A19)],
        ),
      ),
      _QuickAccessItem(
        onTap: () => Get.toNamed(AppRoutes.COMMUNITY),
        icon: Icons.groups,
        title: 'Community',
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4DB6AC), Color(0xFF00897B)],
        ),
      ),
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 24.h,
        childAspectRatio: 0.85,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: item.onTap,
          child: Column(
            children: [
              Container(
                width: 76.w,
                height: 76.w,
                decoration: BoxDecoration(
                  gradient: item.gradient,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Icon(item.icon, color: Colors.white, size: 32.w),
              ),
              SizedBox(height: 10.h),
              Text(
                item.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAllTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onSeeAllTap,
          child: Text(
            'See all',
            style: TextStyle(
              color: const Color(0xFF3B68E7), // Light blue text
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLatestSermonCard(LatestSermonModel data) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.SERMON_DITAILS),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1B233D),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 70.w,
              height: 70.w,
              decoration: BoxDecoration(
                color: const Color(0xFF2844B4),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                color: const Color(0xFFFFC107),
                size: 36.w,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.series,
                    style: TextStyle(
                      color: const Color(0xFF3B68E7),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    data.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    '${data.preacher} · ${data.duration}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 40.w,
              height: 40.w,
              decoration: const BoxDecoration(
                color: Color(0xFFFFC107),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                color: const Color(0xFF0B101E),
                size: 24.w,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(HomeAnnouncementModel data, bool isExpanded) {
    final borderColor = data.isImportant ? const Color(0xFFFF5252) : const Color(0xFF3B68E7);
    final tagColor = data.isImportant ? const Color(0xFFFF5252) : const Color(0xFF3B68E7);
    final tag = data.isImportant ? 'IMPORTANT' : 'ANNOUNCEMENT';

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2336),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor.withOpacity(0.3), width: 1),
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
                                if (data.isImportant) ...[
                                  Icon(
                                    Icons.push_pin,
                                    color: const Color(0xFFFFC107),
                                    size: 16.w,
                                  ),
                                  SizedBox(width: 8.w),
                                ],
                                Expanded(
                                  child: Text(
                                    data.title,
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
                        data.description,
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
                            data.date,
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
                      if (isExpanded && data.imageUrl != null) ...[
                        SizedBox(height: 16.h),
                        Container(
                          height: 350.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            image: DecorationImage(
                              image: AssetImage(data.imageUrl!),
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
