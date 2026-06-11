import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/config/themes/app_theme.dart';
import '../controllers/donate_controller.dart';

class DonateView extends GetView<DonateController> {
  const DonateView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final fund = args?['fund'] ?? 'PIWC-GIFT';
    final amount = args?['amount'] ?? 0;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.transparent
            : AppTheme.containerColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white
                : AppTheme.white,
            size: 24.w,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Donate',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white
                : AppTheme.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.secondaryColor
                : AppTheme.black.withValues(alpha: 0.1),
            height: 1.h,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (controller.isLoading.value) {
                  return Container(
                    height: 200.h,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(color: AppTheme.primaryColor),
                  );
                }

                final details = controller.bankDetails.value;
                if (details == null) {
                  return Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: AppTheme.containerColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Failed to load bank details', style: TextStyle(color: Colors.white)),
                  );
                }

                return Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: AppTheme.successColor, // Green card background
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bank Transfer Details',
                        style: TextStyle(
                          color: AppTheme.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      _buildDetailRow('Account Name', details.accountName),
                      SizedBox(height: 16.h),
                      _buildDetailRow('Sort Code', details.sortCode),
                      SizedBox(height: 16.h),
                      _buildDetailRow('Account No.', details.accountNumber),
                      SizedBox(height: 16.h),
                      _buildDetailRow('Amount', '£$amount'),
                      SizedBox(height: 16.h),
                      _buildDetailRow('Reference', details.reference.isNotEmpty ? details.reference : fund),
                      SizedBox(height: 24.h),
                      Divider(
                        color: AppTheme.white.withValues(alpha: 0.2),
                        thickness: 1,
                        height: 1,
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        details.note.isNotEmpty ? details.note : 'Please use your full name as the payment reference so we can acknowledge your gift.',
                        style: TextStyle(
                          color: AppTheme.white.withValues(alpha: 0.85),
                          fontSize: 14.sp,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 48.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.white
                        : AppTheme.containerColor,
                    foregroundColor: AppTheme.successColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'Finish',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.black
                          : AppTheme.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppTheme.white.withValues(alpha: 0.7),
            fontSize: 15.sp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppTheme.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
