import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/sermon_details_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import 'package:handy/config/themes/app_theme.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../data/models/sermon_response_model.dart';
import '../../../core/services/auth_service.dart';
import '../../../config/routes/app_pages.dart';

class SermondetailsView extends GetView<SermondetailsController> {
  const SermondetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Get the sermon from arguments or controller
      final sermon = controller.sermonDetail.value;

      if (sermon == null) {
        return const Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          body: Center(child: Text("Sermon not found", style: TextStyle(color: Colors.white))),
        );
      }

      return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryLighter, // Lighter blue
                AppTheme.primaryDarker, // Darker blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppTheme.white, size: 24.w),
          onPressed: () => Get.back(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sermon',
              style: TextStyle(
                color: AppTheme.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'PIWC Stoneyburn',
              style: TextStyle(
                color: AppTheme.warningColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        titleSpacing: 0,
        actions: [
          if (Get.parameters['hideSaveIcon'] != 'true')
            Obx(() {
              final profileController = Get.find<ProfileController>();
              final sermonId = sermon.sId ?? sermon.id;
              final isFav = sermonId != null ? profileController.isSermonFavorite(sermonId) : false;
              
              return IconButton(
                icon: Icon(
                  isFav ? Icons.bookmark : Icons.bookmark_border,
                  color: AppTheme.white,
                  size: 24.w,
                ),
                onPressed: () {
                  final authService = Get.find<AuthService>();
                  if (!authService.isLoggedIn.value) {
                    Get.toNamed(AppRoutes.LOGIN);
                    return;
                  }
                  
                  if (sermonId != null) {
                    profileController.toggleFavoriteSermon(sermonId);
                  }
                },
              );
            }),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshData,
        color: AppTheme.primaryColor,
        backgroundColor: AppTheme.containerColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SermonVideoPlayer(),
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      sermon.title ?? 'No Title',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.white
                            : AppTheme.black,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      sermon.speaker ?? 'Unknown Speaker',
                      style: TextStyle(
                        color: AppTheme.accentBlue,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _buildAboutSection(context, sermon),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  });
}

  Widget _buildAboutSection(BuildContext context, SermonModel sermon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (sermon.keyScripture != null && sermon.keyScripture!.isNotEmpty) ...[
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
            ),
            child: Text(
              sermon.keyScripture!,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.white.withValues(alpha: 0.9)
                    : AppTheme.black.withValues(alpha: 0.9),
                fontSize: 16.sp,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
        Text(
          'About This Message',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white
                : AppTheme.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          sermon.description ?? "No description available.",
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white.withValues(alpha: 0.6)
                : AppTheme.black.withValues(alpha: 0.6),
            fontSize: 14.sp,
            height: 1.6,
          ),
        ),
        SizedBox(height: 20.h),
        // Tags
        if (sermon.tags != null && sermon.tags!.isNotEmpty) ...[
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: sermon.tags!.map((tag) => _buildTag('#$tag')).toList(),
          ),
        ] else ...[
          Row(
            children: [
              _buildTag('#hope'),
              SizedBox(width: 12.w),
              _buildTag('#faith'),
            ],
          ),
        ],
        SizedBox(height: 24.h),
        // Share Button
        Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppTheme.primaryLighter, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.share, color: AppTheme.brightBlue, size: 20.w),
              SizedBox(width: 12.w),
              Text(
                'Share This Sermon',
                style: TextStyle(
                  color: AppTheme.brightBlue,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppTheme.containerColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppTheme.white.withValues(alpha: 0.7),
          fontSize: 12.sp,
        ),
      ),
    );
  }
}

class SermonVideoPlayer extends StatefulWidget {
  const SermonVideoPlayer({super.key});

  @override
  State<SermonVideoPlayer> createState() => _SermonVideoPlayerState();
}

class _SermonVideoPlayerState extends State<SermonVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Demo YouTube Video ID
    _controller = YoutubePlayerController.fromVideoId(
      videoId: 'aqz-KE-bpKQ', 
      autoPlay: false,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme.black,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: YoutubePlayer(
          controller: _controller,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}
