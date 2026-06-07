import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/themes/app_theme.dart';
import 'package:handy/data/models/home_model.dart';
import '../../../config/constants/image_paths.dart';
import '../../../config/routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../../bottom_nab_bar/controllers/bottom_nab_bar.dart';

// ignore: unused_element
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70.h),
              Column(
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
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppTheme.backgroundColor
                                : AppTheme.white,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            ImagePaths.appLogo,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.church,
                              size: 24.w,
                              color: AppTheme.white,
                            ),
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
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? AppTheme.white
                                    : AppTheme.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'The Church of Pentecost - UK',
                              style: TextStyle(
                                color: AppTheme.warningColor, // Amber
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
                          color: AppTheme.warningColor,
                          size: 24.w,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.LOGIN),
                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: const BoxDecoration(
                            color: AppTheme.warningColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            color: AppTheme.darkNavy,
                            size: 24.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    ' Welcome, Beloved 🙏',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.white
                          : AppTheme.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
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
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.white
                      : AppTheme.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              _buildQuickAccessGrid(context),
              SizedBox(height: 32.h),
              _buildSectionHeader(
                context,
                'Latest Sermon',
                onSeeAllTap: () =>
                    Get.find<BottomNavBarController>().changeTab(1),
              ),
              SizedBox(height: 16.h),
              _buildLatestSermonCard(controller.homeData.latestSermon),
              SizedBox(height: 32.h),
              _buildSectionHeader(
                context,
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
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppTheme.warningColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'TODAY\'S VERSE',
              style: TextStyle(
                color: AppTheme.navyBlue,
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
              color: AppTheme.white,
              fontSize: 16.sp,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            data.reference,
            style: TextStyle(
              color: AppTheme.warningColor,
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
        color: AppTheme.warningColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: AppTheme.black.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Icons.access_time_filled,
              color: AppTheme.deepBlackBlue.withValues(alpha: 0.7),
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
                    color: AppTheme.deepBlackBlue.withValues(alpha: 0.6),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  data.title,
                  style: TextStyle(
                    color: AppTheme.deepBlackBlue,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  data.schedule,
                  style: TextStyle(
                    color: AppTheme.deepBlackBlue.withValues(alpha: 0.8),
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
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Text(
                'Details',
                style: TextStyle(
                  color: AppTheme.white,
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
          color: AppTheme.watchLiveColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: AppTheme.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 16.w,
                  height: 16.w,
                  decoration: const BoxDecoration(
                    color: AppTheme.white,
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
                      color: AppTheme.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Join Sunday service on YouTube or\nFacebook',
                    style: TextStyle(
                      color: AppTheme.white.withValues(alpha: 0.9),
                      fontSize: 12.sp,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: AppTheme.white, size: 16.w),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuickAccessItem(
              context,
              Icons.video_library_rounded,
              'Sermons',
              [AppTheme.brightBlue, AppTheme.brightBlueDark],
              onTap: () => Get.find<BottomNavBarController>().changeTab(1),
            ),
            _buildQuickAccessItem(
              context,
              Icons.favorite,
              'Give',
              [AppTheme.lightRed, AppTheme.standardRed],
              onTap: () => Get.find<BottomNavBarController>().changeTab(3),
            ),
            _buildQuickAccessItem(
              context,
              Icons.volunteer_activism,
              'Prayer',
              [AppTheme.lightPurple, AppTheme.standardPurple],
              onTap: () => Get.toNamed(AppRoutes.PRAYER_WALL),
            ),
            _buildQuickAccessItem(
              context,
              Icons.groups,
              'Community',
              [AppTheme.lightTeal, AppTheme.standardTeal],
              onTap: () => Get.toNamed(AppRoutes.COMMUNITY),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuickAccessItem(
              context,
              Icons.event,
              'Events',
              [AppTheme.lightGreen, AppTheme.standardGreen],
              onTap: () => Get.find<BottomNavBarController>().changeTab(4),
            ),
            _buildQuickAccessItem(
              context,
              Icons.menu_book,
              'Devotionals',
              [AppTheme.standardOrange, AppTheme.darkOrange],
              onTap: () => Get.toNamed(AppRoutes.DEVOTIONALS),
            ),
            _buildQuickAccessItem(context, Icons.book, 'Bible', [
              AppTheme.teal400,
              AppTheme.darkTeal,
            ], onTap: () => Get.toNamed(AppRoutes.BIBLE)),
            _buildQuickAccessItem(
              context,
              Icons.videocam,
              'Watch Live',
              [AppTheme.lightDeepOrange, AppTheme.darkDeepOrange],
              onTap: () => Get.toNamed(AppRoutes.WATCH_LIVE),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAccessItem(
    BuildContext context,
    IconData icon,
    String title,
    List<Color> gradientColors, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 85.w, // Match more_view width wrapper
        child: Column(
          children: [
            Container(
              width: 65.w,
              height: 65.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors,
                ),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Icon(icon, color: AppTheme.white, size: 30.w),
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.white
                    : AppTheme.black,
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, {VoidCallback? onSeeAllTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white
                : AppTheme.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onSeeAllTap,
          child: Text(
            'See all',
            style: TextStyle(
              color: AppTheme.accentBlue, // Light blue text
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
          color: AppTheme.containerColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppTheme.secondaryColor),
        ),
        child: Row(
          children: [
            Container(
              width: 70.w,
              height: 70.w,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                color: AppTheme.warningColor,
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
                      color: AppTheme.primaryColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    data.title,
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    '${data.preacher} · ${data.duration}',
                    style: TextStyle(
                      color: AppTheme.white.withValues(alpha: 0.6),
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
                color: AppTheme.warningColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                color: AppTheme.deepBlackBlue,
                size: 24.w,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(HomeAnnouncementModel data, bool isExpanded) {
    final tagColor = data.isImportant
        ? AppTheme.accentRed
        : AppTheme.accentBlue;
    final tag = data.isImportant ? 'IMPORTANT' : 'ANNOUNCEMENT';

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
                                if (data.isImportant) ...[
                                  Icon(
                                    Icons.push_pin,
                                    color: AppTheme.warningColor,
                                    size: 16.w,
                                  ),
                                  SizedBox(width: 8.w),
                                ],
                                Expanded(
                                  child: Text(
                                    data.title,
                                    style: TextStyle(
                                      color: AppTheme.white,
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
                        data.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppTheme.white.withValues(alpha: 0.6),
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
                              color: AppTheme.white.withValues(alpha: 0.5),
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            isExpanded ? 'Hide flier' : 'Tap for flier',
                            style: TextStyle(
                              color: AppTheme.accentBlue,
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
