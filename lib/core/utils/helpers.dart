import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:handy/config/themes/app_theme.dart';

enum SnackBarType { success, error, info, warning, secondary }

/// ===================== HELPERS =====================
/// Common utility functions used across the app.
class Helpers {
  Helpers._();

  // ──────────────────── TIME FORMATTING ────────────────────

  /// Format seconds to "mm:ss" (e.g., 125 → "02:05")
  static String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  /// Format seconds to "HH:mm:ss" (e.g., 3661 → "01:01:01")
  static String formatDuration(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final mins = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$hours:$mins:$secs';
  }

  //show bebug log
  static void showDebugLog(String message) {
    debugPrint("❌❌❌❌\n❌❌❌❌DEBUG LOG: $message\n❌❌❌❌");
  }

  // ──────────────────── LOADING DIALOG ────────────────────

  /// Show a centered loading spinner dialog
  static void showLoadingDialog({String? message}) {
    Get.dialog(
      PopScope(
        canPop: false,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              if (message != null) ...[
                SizedBox(height: 16.h),
                Material(
                  color: Colors.transparent,
                  child: Text(
                    message,
                    style: TextStyle(color: AppTheme.white, fontSize: 14.sp),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black54,
    );
  }

  /// Dismiss loading dialog if open
  static void hideLoadingDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  // ──────────────────── SNACKBAR (IPHONE BLUR + IMAGE STYLE) ────────────────────

  /// Show a premium blurred snackbar matching the image layout
  static void showCustomSnackBar(
    String message, {
    String? title,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final Map<String, dynamic> config = _getSnackBarConfig(type);
    final context = Get.context!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Get.rawSnackbar(
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      barBlur: 0,
      messageText: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isDark 
                  ? const Color(0xFF1E1E1E).withValues(alpha: 0.8) 
                  : AppTheme.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: (config['bg'] as Color).withValues(alpha: 0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: (config['bg'] as Color).withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon Area with Glow
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: (config['bg'] as Color).withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    config['icon'], 
                    color: config['bg'], 
                    size: 24.w,
                  ),
                ),
                SizedBox(width: 16.w),
                // Text Content
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? config['defaultTitle'],
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppTheme.white : AppTheme.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        message,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark 
                              ? AppTheme.white.withValues(alpha: 0.7) 
                              : AppTheme.black.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                // Close Button
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.close_rounded,
                    color: isDark 
                        ? AppTheme.white.withValues(alpha: 0.5) 
                        : AppTheme.black.withValues(alpha: 0.5),
                    size: 20.w,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      duration: duration,
      isDismissible: true,
      animationDuration: const Duration(milliseconds: 500),
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static Map<String, dynamic> _getSnackBarConfig(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return {
          'bg': const Color(0xFF10B981),
          'iconBg': const Color(0xFF059669),
          'icon': Icons.check_rounded,
          'defaultTitle': 'Success',
        };
      case SnackBarType.error:
        return {
          'bg': const Color(0xFFEF4444),
          'iconBg': const Color(0xFFDC2626),
          'icon': Icons.block_rounded,
          'defaultTitle': 'Error',
        };
      case SnackBarType.warning:
        return {
          'bg': const Color(0xFFF59E0B),
          'iconBg': const Color(0xFFD97706),
          'icon': Icons.warning_rounded,
          'defaultTitle': 'Warning',
        };
      case SnackBarType.secondary:
        return {
          'bg': const Color(0xFF3B82F6),
          'iconBg': const Color(0xFF2563EB),
          'icon': Icons.notifications_none_rounded,
          'defaultTitle': 'Secondary',
        };
      case SnackBarType.info:
        return {
          'bg': const Color(0xFF9CA3AF),
          'iconBg': const Color(0xFF6B7280),
          'icon': Icons.info_outline_rounded,
          'defaultTitle': 'Info',
        };
    }
  }

  /// Shortcut for Success
  static void showSuccess(String message, {String? title}) {
    showCustomSnackBar(message, title: title, type: SnackBarType.success);
  }

  /// Shortcut for Error
  static void showError(String message, {String? title}) {
    showCustomSnackBar(message, title: title, type: SnackBarType.error);
  }

  /// Shortcut for Warning
  static void showWarning(String message, {String? title}) {
    showCustomSnackBar(message, title: title, type: SnackBarType.warning);
  }

  // ──────────────────── KEYBOARD ────────────────────

  /// Dismiss keyboard
  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  // ──────────────────── DEBOUNCE ────────────────────

  /// Debounce a function call (useful for search inputs)
  static void debounce(
    String tag,
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    if (GetUtils.isNull(tag)) return;
    // Cancel previous timer if exists
    Get.log('Debounce: $tag');
    Future.delayed(duration, callback);
  }
}
