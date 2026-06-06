import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:handy/config/themes/app_theme.dart';

class CustomGradientHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBackButton;
  final Widget? trailingWidget;
  final double? titleFontSize;
  final double? subtitleFontSize;

  const CustomGradientHeader({
    super.key,
    required this.title,
    this.subtitle = 'PIWC Stoneyburn',
    this.showBackButton = false,
    this.trailingWidget,
    this.titleFontSize,
    this.subtitleFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16.h,
        bottom: 16.h,
        left: showBackButton ? 10.w : 20.w,
        right: 20.w,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryLighter,
            AppTheme.primaryDarker,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (showBackButton)
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24.w,
                  ),
                  onPressed: () => Get.back(),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: titleFontSize ?? (showBackButton ? 32.sp : 28.sp),
                      fontWeight: FontWeight.bold,
                      letterSpacing: showBackButton ? -0.5 : 0,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppTheme.warningColor,
                      fontSize: subtitleFontSize ?? (showBackButton ? 14.sp : 12.sp),
                      fontWeight: showBackButton ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (trailingWidget != null) trailingWidget!,
        ],
      ),
    );
  }
}
