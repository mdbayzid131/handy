import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:handy/config/routes/app_pages.dart';
import 'package:handy/config/themes/app_theme.dart';
import 'package:handy/config/constants/api_constants.dart';
import 'package:handy/data/models/sermon_response_model.dart';
import 'package:handy/core/utils/helpers.dart';

class SermonCardWidget extends StatelessWidget {
  final SermonModel sermon;
  final VoidCallback? onTap;

  const SermonCardWidget({super.key, required this.sermon, this.onTap});

  @override
  Widget build(BuildContext context) {
    // Extract base URL correctly (e.g. remove /api/v1)
    final hostUrl = ApiConstants.baseUrl.replaceAll('/api/v1', '');

    return GestureDetector(
      onTap:
          onTap ??
          () {
            Get.toNamed(AppRoutes.SERMON_DETAILS, arguments: sermon);
          },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppTheme.containerColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppTheme.secondaryColor, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: SizedBox(
                width: 80.w,
                height: 80.w,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          (sermon.thumbnailUrl != null &&
                              sermon.thumbnailUrl!.isNotEmpty)
                          ? '$hostUrl${sermon.thumbnailUrl}'
                          : 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?q=80&w=200&auto=format&fit=crop',
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: AppTheme.primaryColor),
                      errorWidget: (context, url, error) => CachedNetworkImage(
                        imageUrl:
                            'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?q=80&w=200&auto=format&fit=crop',
                        fit: BoxFit.cover,
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
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (sermon.category?.name != null &&
                      sermon.category!.name != 'Unknown Category') ...[
                    Text(
                      sermon.category!.name!,
                      style: TextStyle(
                        color: AppTheme.accentYellow,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: 6.h),
                  ],
                  Text(
                    sermon.title ?? 'No Title',
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    sermon.speaker ?? 'Unknown Speaker',
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
                        _formatDate(sermon.date),
                        style: TextStyle(
                          color: AppTheme.white.withValues(alpha: 0.5),
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        Helpers.formatTime(sermon.durationSeconds ?? 0),
                        style: TextStyle(
                          color: AppTheme.accentYellow,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'Unknown Date';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM d, yyyy').format(date);
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
