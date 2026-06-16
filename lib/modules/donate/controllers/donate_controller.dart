import 'package:get/get.dart';
import 'package:handy/config/constants/api_constants.dart';
import 'package:handy/core/services/api_client.dart';
import 'package:handy/core/utils/helpers.dart';
import '../../../data/models/give_model.dart';
import 'package:handy/modules/give/controllers/give_controller.dart';

class DonateController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();

  final bankDetails = Rxn<BankDetailsModel>();
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBankDetails();
  }

  final isSubmitting = false.obs;

  Future<void> fetchBankDetails() async {
    isLoading.value = true;
    try {
      final response = await apiClient.getData(ApiConstants.givingBankDetails);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          bankDetails.value = BankDetailsModel.fromJson(response.data['data']);
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching bank details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> recordTransaction({
    required String fundId,
    required double amount,
    required String reference,
  }) async {
    isSubmitting.value = true;
    try {
      final body = {
        "fundId": fundId,
        "amount": amount,
        "currency": "GBP",
        "status": "completed",
        "reference": reference,
      };

      final response = await apiClient.postData(
        ApiConstants.givingRecord,
        body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back(); // Close the page first
        
        // Use a tiny delay to allow the route to pop before showing the snackbar
        Future.delayed(const Duration(milliseconds: 100), () {
          Helpers.showSuccess('Transaction recorded successfully');
        });

        // Refresh GiveController data so the total updates
        if (Get.isRegistered<GiveController>()) {
          Get.find<GiveController>().fetchFunds();
          Get.find<GiveController>().selectedAmount.value = 0;
          Get.find<GiveController>().amountController.clear();
        }
      } else {
        Helpers.showError(response.data['message'] ?? 'Failed to record transaction');
      }
    } catch (e) {
      Helpers.showDebugLog('Error recording transaction: $e');
      Helpers.showError('An error occurred');
    } finally {
      isSubmitting.value = false;
    }
  }
}
