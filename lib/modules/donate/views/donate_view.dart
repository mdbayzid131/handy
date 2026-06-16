import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/shimmers/shimmer_helper.dart';
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: isDarkMode ? Colors.transparent : AppTheme.containerColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppTheme.white,
            size: 24.w,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Donate',
          style: TextStyle(
            color: AppTheme.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            color: isDarkMode
                ? AppTheme.secondaryColor
                : AppTheme.black.withValues(alpha: 0.1),
            height: 1.h,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: controller.fetchBankDetails,
        color: AppTheme.primaryColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    if (controller.isLoading.value) {
                      return ShimmerHelper(
                        child: Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: AppTheme.secondaryColor,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShimmerContainer(width: 100.w, height: 16.h),
                              SizedBox(height: 8.h),
                              ShimmerContainer(width: double.infinity, height: 24.h),
                              SizedBox(height: 16.h),
                              ShimmerContainer(width: 80.w, height: 16.h),
                              SizedBox(height: 8.h),
                              ShimmerContainer(width: double.infinity, height: 24.h),
                              SizedBox(height: 16.h),
                              ShimmerContainer(width: 120.w, height: 16.h),
                              SizedBox(height: 8.h),
                              ShimmerContainer(width: double.infinity, height: 24.h),
                            ],
                          ),
                        ),
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
                        child: const Text(
                          'Failed to load bank details',
                          style: TextStyle(color: Colors.white),
                        ),
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
                          _buildDetailRow('Reference', fund),
                          SizedBox(height: 24.h),
                          Divider(
                            color: AppTheme.white.withValues(alpha: 0.2),
                            thickness: 1,
                            height: 1,
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            details.note.isNotEmpty
                                ? details.note
                                : 'Please use your full name as the payment reference so we can acknowledge your gift.',
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
                    child: Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode ? AppTheme.white : AppTheme.containerColor,
                        foregroundColor: AppTheme.successColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: controller.isSubmitting.value 
                        ? null 
                        : () {
                            if (args != null && args['fundId'] != null) {
                              controller.recordTransaction(
                                fundId: args['fundId'],
                                amount: (args['amount'] as num).toDouble(),
                                reference: args['fund'] ?? '',
                              );
                            } else {
                              Get.back();
                            }
                          },
                      child: controller.isSubmitting.value
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: CircularProgressIndicator(
                              color: isDarkMode ? AppTheme.black : AppTheme.successColor,
                              strokeWidth: 2.w,
                            ),
                          )
                        : Text(
                            'Finish',
                            style: TextStyle(
                              color: isDarkMode ? AppTheme.black : AppTheme.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    )),
                  ),
                ],
              ),
            ),
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
