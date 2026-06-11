import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/core/services/api_client.dart';
import 'package:handy/config/constants/api_constants.dart';
import 'package:handy/core/utils/helpers.dart';
import '../../../data/models/give_model.dart';

class GiveController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();

  final showHistory = false.obs;
  final isLoading = true.obs;
  
  final totalThisYear = 0.obs;

  final selectedFund = 'Offering'.obs;
  final selectedAmount = 0.obs;

  final amountController = TextEditingController();

  final selectedFrequency = 'One-time'.obs;
  final selectedPaymentMethod = 'Card (Stripe)'.obs;

  final funds = <GiveFundModel>[].obs;

  final List<int> presetAmounts = [10, 20, 50, 100, 250, 500];

  final historyData = <GiveHistoryModel>[].obs;
  final isHistoryLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFunds();
    amountController.addListener(() {
      if (amountController.text.isNotEmpty) {
        final val = int.tryParse(amountController.text) ?? 0;
        selectedAmount.value = val;
      } else {
        selectedAmount.value = 0;
      }
    });
  }

  Future<void> fetchFunds() async {
    isLoading.value = true;
    try {
      final futures = await Future.wait([
        apiClient.getData(ApiConstants.givingFunds),
        apiClient.getData(ApiConstants.givingTotalThisYear),
      ]);
      
      final fundsResponse = futures[0];
      final totalResponse = futures[1];

      if (fundsResponse.statusCode == 200 || fundsResponse.statusCode == 201) {
        if (fundsResponse.data['data'] != null) {
          final fundsList = (fundsResponse.data['data'] as List)
              .map((x) => GiveFundModel.fromJson(x as Map<String, dynamic>))
              .toList();
          funds.assignAll(fundsList);
        }
      }
      
      if (totalResponse.statusCode == 200 || totalResponse.statusCode == 201) {
        if (totalResponse.data['data'] != null && totalResponse.data['data']['totalThisYear'] != null) {
          totalThisYear.value = (totalResponse.data['data']['totalThisYear'] as num).toInt();
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Failed to fetch data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  final isSubmitting = false.obs;

  Future<void> recordTransaction() async {
    if (selectedAmount.value <= 0) {
      Helpers.showError('Please enter a valid amount');
      return;
    }
    
    if (selectedFund.value.isEmpty) {
      Helpers.showError('Please select a fund');
      return;
    }

    final fund = funds.firstWhereOrNull((f) => f.title == selectedFund.value);
    if (fund == null) {
      Helpers.showError('Selected fund not found');
      return;
    }

    isSubmitting.value = true;
    try {
      final body = {
        "fundId": fund.id,
        "amount": selectedAmount.value.toDouble(),
        "currency": "GBP",
        "status": "completed",
        "reference": "TXN-${DateTime.now().millisecondsSinceEpoch}"
      };

      final response = await apiClient.postData(ApiConstants.givingRecord, body);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        Helpers.showSuccess('Transaction recorded successfully');
        // Reset form
        selectedAmount.value = 0;
        amountController.clear();
        
        // Refresh total
        await fetchFunds();
      }
    } catch (e) {
      Helpers.showDebugLog('Failed to record transaction: $e');
      Helpers.showError('Failed to process transaction. Please try again.');
    } finally {
      isSubmitting.value = false;
    }
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

  Future<void> fetchHistory() async {
    isHistoryLoading.value = true;
    try {
      final response = await apiClient.getData(ApiConstants.givingHistory);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null && response.data['data']['transactions'] != null) {
          final list = (response.data['data']['transactions'] as List)
              .map((x) => GiveHistoryModel.fromJson(x))
              .toList();
          historyData.assignAll(list);
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Failed to fetch history: $e');
    } finally {
      isHistoryLoading.value = false;
    }
  }

  void toggleHistory() {
    showHistory.value = !showHistory.value;
    if (showHistory.value && historyData.isEmpty) {
      fetchHistory();
    }
  }
}
