import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/give_model.dart';
import 'package:handy/config/themes/app_theme.dart';

class GiveController extends GetxController {
  final showHistory = false.obs;
  
  final selectedFund = 'Offering'.obs;
  final selectedAmount = 0.obs;
  
  final amountController = TextEditingController();
  
  final selectedFrequency = 'One-time'.obs;
  final selectedPaymentMethod = 'Card (Stripe)'.obs;

  final List<GiveFundModel> funds = [
    GiveFundModel(
      title: 'Tithe',
      desc: 'Your regular 10% offering',
      icon: Icons.attach_money,
      color: AppTheme.accentBlue,
    ),
    GiveFundModel(
      title: 'Offering',
      desc: 'Freewill offering to the Lord',
      icon: Icons.favorite,
      color: const Color(0xFFFF5252),
    ),
    GiveFundModel(
      title: 'Missions',
      desc: 'Support global outreach',
      icon: Icons.language,
      color: const Color(0xFF00E676),
    ),
    GiveFundModel(
      title: 'Building Fund',
      desc: 'Help us build for the future',
      icon: Icons.star,
      color: const Color(0xFFFF9800),
    ),
  ];

  final List<int> presetAmounts = [10, 20, 50, 100, 250, 500];

  final List<GiveHistoryModel> historyData = [
    GiveHistoryModel(
      title: 'Tithe',
      amount: '£250.00',
      date: 'Apr 27, 2026',
      status: 'Completed',
    ),
    GiveHistoryModel(
      title: 'Offering',
      amount: '£50.00',
      date: 'Apr 20, 2026',
      status: 'Completed',
    ),
    GiveHistoryModel(
      title: 'Building Fund',
      amount: '£100.00',
      date: 'Apr 13, 2026',
      status: 'Completed',
    ),
    GiveHistoryModel(
      title: 'Missions',
      amount: '£75.00',
      date: 'Apr 6, 2026',
      status: 'Completed',
    ),
  ];
  
  @override
  void onInit() {
    super.onInit();
    amountController.addListener(() {
      if (amountController.text.isNotEmpty) {
        final val = int.tryParse(amountController.text) ?? 0;
        selectedAmount.value = val;
      } else {
        selectedAmount.value = 0;
      }
    });
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }

  void selectAmount(int amount) {
    selectedAmount.value = amount;
    amountController.text = amount.toString();
  }
  
  void toggleHistory() {
    showHistory.value = !showHistory.value;
  }
}