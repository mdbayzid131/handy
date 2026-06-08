import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/sermon_ditails_contoller.dart';
import 'package:handy/config/themes/app_theme.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SermonDitailsView extends GetView<SermonDitailsController> {
  const SermonDitailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final sermon = controller.sermon;

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
          IconButton(
            icon: Icon(
              Icons.bookmark_border,
              color: AppTheme.white,
              size: 24.w,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                      sermon.title,
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
                      sermon.pastor,
                      style: TextStyle(
                        color: AppTheme.accentBlue,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _buildAboutSection(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          "In uncertain times, our hope is not wishful thinking but a firm anchor rooted in God's promises. This message explores Hebrews 6 and what it means to hold fast to hope.",
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
        Row(
          children: [
            _buildTag('#hope'),
            SizedBox(width: 12.w),
            _buildTag('#faith'),
            SizedBox(width: 12.w),
            _buildTag('#promises'),
          ],
        ),
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
