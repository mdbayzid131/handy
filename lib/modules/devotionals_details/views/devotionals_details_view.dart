import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/themes/app_theme.dart';

class DevotionalsDetailsView extends StatelessWidget {
  const DevotionalsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.backgroundColor
            : AppTheme.containerColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white
                : AppTheme.black,
            size: 24.w,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          'Devotional',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white
                : AppTheme.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.star_border,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.white
                  : AppTheme.black,
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
              // Top Blue Header
              Container(
                width: double.infinity,
                color: AppTheme.royalBlue, // Royal Blue
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TUESDAY · MAY 6, 2025',
                      style: TextStyle(
                        color: AppTheme.white.withValues(alpha: 0.7),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'More Than Enough',
                      style: TextStyle(
                        color: AppTheme.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Scripture Container
              Container(
                margin: EdgeInsets.all(20.w),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: AppTheme.containerColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: AppTheme.royalBlue, width: 4.w),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'JOHN 6:35',
                        style: TextStyle(
                          color: AppTheme.royalBlue,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        '"Jesus said to them, \'I am the bread of life; whoever comes to me shall not hunger, and whoever believes in me shall never thirst.\'"',
                        style: TextStyle(
                          color: AppTheme.white,
                          fontSize: 16.sp,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Reflection Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.menu_book,
                          color: AppTheme.royalBlue,
                          size: 24.w,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Reflection',
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppTheme.white
                                : AppTheme.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Jesus does not offer to supplement our lives — He offers to satisfy them. The crowd had just witnessed the miracle of loaves and fish, yet Jesus pointed beyond the physical to a deeper hunger. Every longing we carry — for meaning, for belonging, for peace — finds its answer in Him. Come to Him today, not just for what He can do, but for who He is.',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.white.withValues(alpha: 0.9)
                            : AppTheme.black.withValues(alpha: 0.9),
                        fontSize: 15.sp,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              // Prayer Section
              Container(
                margin: EdgeInsets.all(20.w),
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppTheme.containerColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: const Color(0xFF9C27B0),
                          size: 20.w,
                        ), // Purple heart-like icon
                        SizedBox(width: 12.w),
                        Text(
                          'Prayer',
                          style: TextStyle(
                            color: AppTheme.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Jesus, You are the bread of life. I confess that I often look for satisfaction in other places. Fill me today with the only thing that truly satisfies. Amen.',
                      style: TextStyle(
                        color: AppTheme.mutedTextColor,
                        fontSize: 15.sp,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.royalBlue,
                        minimumSize: Size(double.infinity, 56.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppTheme.white,
                            size: 20.w,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Mark as Read',
                            style: TextStyle(
                              color: AppTheme.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: AppTheme.containerColor,
                          width: 1.5,
                        ),
                        minimumSize: Size(double.infinity, 56.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share,
                            color: AppTheme.royalBlue,
                            size: 20.w,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Share This Devotional',
                            style: TextStyle(
                              color: AppTheme.royalBlue,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
