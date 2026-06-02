import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/give_controller.dart';

class GiveView extends GetView<GiveController> {
  const GiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SafeArea(
              top: false,
              child: Obx(
                () => controller.showHistory.value
                    ? _buildHistoryList()
                    : _buildGiveForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF132488), // Deep blue at top
            Color(0xFF091244), // Darker blue at bottom
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 10.h,
            bottom: 20.h,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Give',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'PIWC Stoneyburn',
                        style: TextStyle(
                          color: const Color(0xFFFFC107),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => GestureDetector(
                      onTap: () => controller.toggleHistory(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFC107),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              controller.showHistory.value
                                  ? Icons.arrow_back_rounded
                                  : Icons.history_rounded,
                              color: Colors.black,
                              size: 16.w,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              controller.showHistory.value ? 'Back' : 'History',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your giving this year',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      '£475.00',
                      style: TextStyle(
                        color: const Color(0xFFFFC107),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGiveForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Select Fund'),
          _buildFundGrid(),
          SizedBox(height: 24.h),
          _buildSectionTitle('Amount (£)'),
          _buildAmountSelection(),
          SizedBox(height: 24.h),
          _buildSectionTitle('Frequency'),
          _buildFrequencySelection(),
          SizedBox(height: 24.h),
          _buildSectionTitle('Payment Method'),
          _buildPaymentMethodSelection(),
          SizedBox(height: 32.h),
          _buildGiveNowButton(),
          SizedBox(height: 16.h),
          _buildSecurePaymentNote(),
          SizedBox(height: 24.h),
          _buildQuoteBox(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFundGrid() {
    final funds = [
      {
        'title': 'Tithe',
        'desc': 'Your regular 10% offering',
        'icon': Icons.attach_money,
        'color': const Color(0xFF3B68E7),
      },
      {
        'title': 'Offering',
        'desc': 'Freewill offering to the Lord',
        'icon': Icons.favorite,
        'color': const Color(0xFFFF5252),
      },
      {
        'title': 'Missions',
        'desc': 'Support global outreach',
        'icon': Icons.language,
        'color': const Color(0xFF00E676),
      },
      {
        'title': 'Building Fund',
        'desc': 'Help us build for the future',
        'icon': Icons.star,
        'color': const Color(0xFFFF9800),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: funds.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, index) {
        final fund = funds[index];
        return Obx(() {
          final isSelected = controller.selectedFund.value == fund['title'];
          return GestureDetector(
            onTap: () =>
                controller.selectedFund.value = fund['title'] as String,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? (fund['color'] as Color)
                    : const Color(0xFF1E2336),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.05),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    fund['icon'] as IconData,
                    color: isSelected ? Colors.white : (fund['color'] as Color),
                    size: 24.w,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    fund['title'] as String,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    fund['desc'] as String,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white.withOpacity(0.9)
                          : Colors.white.withOpacity(0.5),
                      fontSize: 11.sp,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Widget _buildAmountSelection() {
    final amounts = [10, 20, 50, 100, 200];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: amounts
              .map(
                (amount) => Obx(() {
                  final isSelected = controller.selectedAmount.value == amount;
                  return GestureDetector(
                    onTap: () {
                      controller.selectedAmount.value = amount;
                      controller.customAmount.value = '';
                    },
                    child: Container(
                      width: 60.w,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF132488)
                            : const Color(0xFF1E2336),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF3B68E7)
                              : Colors.white.withOpacity(0.05),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '£$amount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              )
              .toList(),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2336),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              Text(
                '£',
                style: TextStyle(
                  color: const Color(0xFF3B68E7),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Obx(() {
                  final amount = controller.selectedAmount.value;
                  return Text(
                    amount > 0 ? amount.toString() : 'Enter amount',
                    style: TextStyle(
                      color: amount > 0 ? Colors.white : Colors.white.withOpacity(0.5),
                      fontSize: 16.sp,
                      fontWeight: amount > 0 ? FontWeight.bold : FontWeight.w600,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFrequencySelection() {
    final frequencies = ['One-time', 'Weekly', 'Monthly'];
    return Row(
      children: frequencies
          .map(
            (freq) => Expanded(
              child: Obx(() {
                final isSelected = controller.selectedFrequency.value == freq;
                return GestureDetector(
                  onTap: () => controller.selectedFrequency.value = freq,
                  child: Container(
                    margin: EdgeInsets.only(
                      right: freq != 'Monthly' ? 12.w : 0,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF3B68E7)
                          : const Color(0xFF1E2336),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF3B68E7)
                            : Colors.white.withOpacity(0.05),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        freq,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          )
          .toList(),
    );
  }

  Widget _buildPaymentMethodSelection() {
    final methods = [
      {
        'id': 'Card (Stripe)',
        'title': 'Card (Stripe)',
        'desc': 'Visa, Mastercard, American Express',
        'icon': Icons.credit_card,
        'color': const Color(0xFF3B68E7),
      },
      {
        'id': 'PayPal',
        'title': 'PayPal',
        'desc': 'Pay with your PayPal account',
        'icon': Icons.attach_money,
        'color': const Color(0xFF0091EA),
      },
      {
        'id': 'Bank Transfer',
        'title': 'Bank Transfer',
        'desc': 'Direct bank transfer (BACS)',
        'icon': Icons.account_balance,
        'color': const Color(0xFF4CAF50),
      },
    ];

    return Column(
      children: methods
          .map(
            (method) => Obx(() {
              final isSelected =
                  controller.selectedPaymentMethod.value == method['id'];
              return GestureDetector(
                onTap: () => controller.selectedPaymentMethod.value =
                    method['id'] as String,
                child: Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2336),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF3B68E7)
                          : Colors.white.withOpacity(0.05),
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: method['color'] as Color,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: method['icon'] != null
                            ? Icon(
                                method['icon'] as IconData,
                                color: Colors.white,
                                size: 20.w,
                              )
                            : null,
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              method['title'] as String,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              method['desc'] as String,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Container(
                          width: 24.w,
                          height: 24.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFF3B68E7),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16.w,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          )
          .toList(),
    );
  }

  Widget _buildGiveNowButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFF9800), // Orange
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite, color: const Color(0xFF132488), size: 20.w),
          SizedBox(width: 8.w),
          Text(
            'Give Now',
            style: TextStyle(
              color: const Color(0xFF132488),
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8.w),
          Icon(Icons.chevron_right, color: const Color(0xFF132488), size: 20.w),
        ],
      ),
    );
  }

  Widget _buildSecurePaymentNote() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.lock, color: const Color(0xFFFFC107), size: 14.w),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            'Secure payment · Redirects to Card (Stripe) to complete your gift',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuoteBox() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2336).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"Each of you should give what you have decided in your heart to give, not reluctantly or under compulsion, for God loves a cheerful giver."',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14.sp,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            '— 2 Corinthians 9:7',
            style: TextStyle(
              color: const Color(0xFF3B68E7),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Giving History List
  Widget _buildHistoryList() {
    final historyData = [
      {
        'title': 'Tithe',
        'amount': '£250.00',
        'date': 'Apr 27, 2026',
        'status': 'Completed',
      },
      {
        'title': 'Offering',
        'amount': '£50.00',
        'date': 'Apr 20, 2026',
        'status': 'Completed',
      },
      {
        'title': 'Building Fund',
        'amount': '£100.00',
        'date': 'Apr 13, 2026',
        'status': 'Completed',
      },
      {
        'title': 'Missions',
        'amount': '£75.00',
        'date': 'Apr 6, 2026',
        'status': 'Completed',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(20.w),
          child: Text(
            'Giving History',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
            itemCount: historyData.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final item = historyData[index];
              return Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2336),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B68E7), // Blue heart box
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 20.w,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            item['date']!,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item['amount']!,
                          style: TextStyle(
                            color: const Color(0xFF3B68E7),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00E676).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            item['status']!,
                            style: TextStyle(
                              color: const Color(0xFF00E676),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
