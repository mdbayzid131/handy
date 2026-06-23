import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:handy/config/themes/app_theme.dart';
import 'package:handy/data/models/home_model.dart';
import '../../../config/constants/image_paths.dart';
import '../../../config/routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../../bottom_nab_bar/controllers/bottom_nab_bar.dart';
import 'package:handy/core/widgets/cards/event_card.dart';
import 'package:handy/data/models/events_model.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/widgets/shimmers/shimmer_helper.dart';
import '../../../core/widgets/shimmers/sermon_card_shimmer.dart';
import '../../../core/widgets/shimmers/event_card_shimmer.dart';

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
      body: RefreshIndicator(
        onRefresh: controller.refreshHome,
        color: AppTheme.primaryColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppTheme.backgroundColor
                                : AppTheme.white,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              ImagePaths.appLogo,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
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
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
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
                          onTap: () {
                            final authService = Get.find<AuthService>();
                            if (authService.isLoggedIn.value || authService.currentUser.value != null) {
                              Get.find<BottomNavBarController>().goToProfile();
                            } else {
                              Get.toNamed(AppRoutes.LOGIN);
                            }
                          },
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
                _buildDailyDevotionalCard(),
                SizedBox(height: 16.h),
                _buildNextServiceCard(),
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
                Obx(() {
                  if (controller.isLoadingSermon.value &&
                      controller.latestSermon.value == null) {
                    return const SermonCardShimmer();
                  }
                  if (controller.latestSermon.value == null) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Text(
                          'No latest sermon available',
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppTheme.white
                                : AppTheme.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    );
                  }
                  return _buildLatestSermonCard(controller.latestSermon.value!);
                }),
                SizedBox(height: 32.h),
                _buildSectionHeader(
                  context,
                  'Events',
                  onSeeAllTap: () =>
                      Get.find<BottomNavBarController>().changeTab(3),
                ),
                SizedBox(height: 16.h),
                Obx(() {
                  if (controller.isLoadingEvents.value &&
                      controller.latestEvents.isEmpty) {
                    return Column(
                      children: List.generate(
                        2,
                        (index) => const EventCardShimmer(),
                      ),
                    );
                  }
                  if (controller.latestEvents.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Text(
                          'No upcoming events',
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppTheme.white
                                : AppTheme.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: controller.latestEvents.map<Widget>((
                      EventModel event,
                    ) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: EventCard(event: event),
                      );
                    }).toList(),
                  );
                }),
                SizedBox(height: 28.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDailyDevotionalCard() {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.DEVOTIONALS),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30.w,
                      height: 30.w,
                      decoration: BoxDecoration(
                        color: AppTheme.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.bolt,
                        color: AppTheme.warningColor,
                        size: 16.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Daily Devotionals',
                      style: TextStyle(
                        color: AppTheme.white.withValues(alpha: 0.8),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  'Your Weekly\nProgress',
                  style: TextStyle(
                    color: AppTheme.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ],
            ),
            Obx(() {
              final progress = controller.devotionalProgress.value;
              final isLoading = controller.isLoadingDevotional.value;

              if (isLoading) {
                return ShimmerHelper(
                  child: ShimmerContainer(
                    width: 80.w,
                    height: 80.w,
                    shape: BoxShape.circle,
                  ),
                );
              }

              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.white.withValues(alpha: 0.5),
                        width: 8.w,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$progress/7',
                        style: TextStyle(
                          color: AppTheme.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'day',
                        style: TextStyle(
                          color: AppTheme.white.withValues(alpha: 0.8),
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNextServiceCard() {
    return Obx(() {
      final schedule = controller.contactMission.value?.sundayService;
      final scheduleText = schedule != null && schedule.isNotEmpty
          ? 'Sunday · ${schedule.split(',').join(' - ')}'
          : 'Sunday · No schedule';

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
                    'NEXT SERVICE',
                    style: TextStyle(
                      color: AppTheme.deepBlackBlue.withValues(alpha: 0.6),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Sunday Worship',
                    style: TextStyle(
                      color: AppTheme.deepBlackBlue,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    scheduleText,
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
    });
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
              onTap: () => Get.find<BottomNavBarController>().changeTab(2),
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
              onTap: () => Get.find<BottomNavBarController>().changeTab(3),
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

  Widget _buildSectionHeader(
    BuildContext context,
    String title, {
    VoidCallback? onSeeAllTap,
  }) {
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
      onTap: () => Get.toNamed(AppRoutes.SERMON_DETAILS, arguments: data.id),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppTheme.containerColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppTheme.secondaryColor, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: CachedNetworkImage(
                      imageUrl: data.thumbnailUrl != null
                          ? 'https://church-app-ooku.onrender.com${data.thumbnailUrl}'
                          : 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?q=80&w=200&auto=format&fit=crop',
                      memCacheWidth: 400,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: AppTheme.primaryColor),
                      errorWidget: (context, url, error) => CachedNetworkImage(
                        imageUrl:
                            'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?q=80&w=200&auto=format&fit=crop',
                        memCacheWidth: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: AppTheme.black.withValues(alpha: 0.4),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: AppTheme.white,
                        size: 20.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.series,
                    style: TextStyle(
                      color: AppTheme.accentYellow,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    data.title,
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    data.preacher,
                    style: TextStyle(
                      color: AppTheme.white.withValues(alpha: 0.6),
                      fontSize: 13.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent',
                        style: TextStyle(
                          color: AppTheme.white.withValues(alpha: 0.5),
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        data.duration,
                        style: TextStyle(
                          color: AppTheme.accentYellow,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
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
}
