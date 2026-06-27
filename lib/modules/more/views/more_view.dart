import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:handy/modules/bottom_nab_bar/controllers/bottom_nab_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:handy/config/themes/app_theme.dart';
import '../../../config/routes/app_pages.dart';
import 'package:handy/core/widgets/custom_gradient_header.dart';
import '../controllers/more_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:handy/data/models/contact_mission_model.dart';

class MoreView extends GetView<MoreController> {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomGradientHeader(title: 'More'),
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.refreshData,
              color: AppTheme.primaryColor,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Features',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.white
                            : AppTheme.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _buildFeaturesGrid(context),
                    SizedBox(height: 32.h),
                    Text(
                      'Connect With Us',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.white
                            : AppTheme.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(height: 20.h),
                    Obx(() {
                      if (controller.isLoading.value &&
                          controller.contactMission.value == null) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.primaryColor,
                          ),
                        );
                      }

                      return Column(
                        children: [
                          _buildConnectCard(controller.contactMission.value),
                          SizedBox(height: 24.h),
                          _buildReportCard(),
                          _buildMissionCard(controller.contactMission.value),
                        ],
                      );
                    }),
                    SizedBox(height: 40.h), // padding at bottom
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFeatureItem(
              context,
              Icons.volunteer_activism,
              'Prayer Wall',
              [AppTheme.purple300, AppTheme.purple800],
              onTap: () => Get.toNamed(AppRoutes.PRAYER_WALL),
            ),
            _buildFeatureItem(
              context,
              Icons.menu_book,
              'Devotionals',
              [AppTheme.lightOrange, AppTheme.darkOrange],
              onTap: () => Get.toNamed(AppRoutes.DEVOTIONALS),
            ),
            _buildFeatureItem(
              context,
              Icons.groups,
              'Community',
              [AppTheme.lightTeal, AppTheme.darkTeal],
              onTap: () => Get.toNamed(AppRoutes.COMMUNITY),
            ),
            _buildFeatureItem(context, Icons.book, 'Bible', [
              AppTheme.green300,
              AppTheme.standardGreen,
            ], onTap: () => Get.toNamed(AppRoutes.BIBLE)),
          ],
        ),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFeatureItem(
              context,
              Icons.person,
              'My Profile',
              [AppTheme.lightBlue, AppTheme.standardBlue],
              onTap: () {
                Get.find<BottomNavBarController>().goToProfile();
              },
            ),
            _buildFeatureItem(
              context,
              Icons.settings,
              'Settings',
              [AppTheme.blueGreyLight, AppTheme.blueGreyDark],
              onTap: () => Get.toNamed(AppRoutes.SETTINGS),
            ),
            _buildFeatureItem(
              context,
              Icons.auto_stories,
              'History and\nCore Values',
              [
                const Color.fromARGB(255, 45, 42, 245),
                const Color.fromARGB(255, 62, 35, 171),
              ],
              onTap: () => Get.toNamed(AppRoutes.HISTORY_AND_CORE_VALUES),
            ),
            _buildFeatureItem(
              context,
              Icons.people,
              'Attendance',
              [const Color(0xFF00C9FF), const Color(0xFF92FE9D)],
              onTap: () async {
                final Uri url = Uri.parse(
                  'https://app.copscotland.org/index.php?assembly_id=8',
                );
                if (!await launchUrl(
                  url,
                  mode: LaunchMode.externalApplication,
                )) {
                  Get.snackbar('Error', 'Could not launch website');
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    IconData icon,
    String title,
    List<Color> gradientColors, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 65.w,
            height: 65.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
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
    );
  }

  Widget _buildConnectCard(ContactMissionModel? data) {
    final address = data?.address?.trim().isNotEmpty == true
        ? data!.address!
        : 'Not Available';

    final email = data?.email?.trim().isNotEmpty == true
        ? data!.email!
        : 'Not Available';
    final website = data?.website?.trim().isNotEmpty == true
        ? data!.website!
        : 'Not Available';

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor, // Blue card background
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppTheme.warningColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'THE CHURCH OF PENTECOST · UK',
              style: TextStyle(
                color: AppTheme.darkNavy,
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'PIWC Stoneyburn',
            style: TextStyle(
              color: AppTheme.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24.h),
          _buildConnectRow(Icons.location_on, 'Address', address),
          SizedBox(height: 20.h),
          _buildConnectRow(
            Icons.access_time,
            'Sunday Service',
            controller.formattedSundayService,
          ),
          SizedBox(height: 20.h),
          _buildConnectRow(Icons.email, 'Email', email),
          SizedBox(height: 20.h),
          _buildConnectRow(Icons.language, 'Website', website),
          SizedBox(height: 20.h),
          _buildConnectRow(
            FontAwesomeIcons.youtube,
            'YouTube',
            _getSocialUrl(data, 'youtube'),
          ),
          SizedBox(height: 20.h),
          _buildConnectRow(
            FontAwesomeIcons.instagram,
            'Instagram',
            _getSocialUrl(data, 'instagram'),
          ),
        ],
      ),
    );
  }

  String _getSocialUrl(ContactMissionModel? data, String platform) {
    if (data?.socialLinks != null) {
      for (var link in data!.socialLinks!) {
        if (link.platform?.toLowerCase() == platform.toLowerCase() &&
            link.url != null &&
            link.url!.isNotEmpty) {
          return link.url!;
        }
      }
    }
    return 'Not Available';
  }

  Widget _buildConnectRow(dynamic icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppTheme.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: icon is IconData
              ? Icon(icon, color: AppTheme.warningColor, size: 20.w)
              : FaIcon(icon, color: AppTheme.warningColor, size: 20.w),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: AppTheme.white.withValues(alpha: 0.6),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: TextStyle(
                  color: AppTheme.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMissionCard(ContactMissionModel? data) {
    final mission = data?.ourMission?.trim().isNotEmpty == true
        ? data!.ourMission!
        : 'Mission statement is currently unavailable.';

    return Container(
      padding: EdgeInsets.all(20.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.warningColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OUR MISSION',
            style: TextStyle(
              color: AppTheme.darkNavy,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            mission,
            style: TextStyle(
              color: AppTheme.darkNavy.withValues(alpha: 0.8),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard() {
    return GestureDetector(
      onTap: () => _showReportBottomSheet(),
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppTheme.secondaryColor),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.50),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.report_problem_rounded,
                color: Colors.red,
                size: 24.w,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Report',
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
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

  void _showReportBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Report',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.white,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.white,
                  ),
                ),
                SizedBox(height: 8.h),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Title',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 71, 103, 231),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: AppTheme.white),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.white,
                  ),
                ),
                SizedBox(height: 8.h),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 71, 103, 231),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: AppTheme.white),
                ),
                SizedBox(height: 32.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          side: BorderSide(color: AppTheme.secondaryColor),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppTheme.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // API call later
                          Get.back();
                          Get.snackbar(
                            'Thank you!',
                            'Your report has been submitted.',
                            backgroundColor: AppTheme.primaryColor,
                            colorText: AppTheme.white,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: AppTheme.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
  }
}
