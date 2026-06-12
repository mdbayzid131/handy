import 'package:get/get.dart';
import 'package:handy/config/constants/api_constants.dart';
import 'package:handy/core/services/api_client.dart';
import 'package:handy/core/utils/helpers.dart';
import '../../../data/models/give_model.dart';

class DonateController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();

  final bankDetails = Rxn<BankDetailsModel>();
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBankDetails();
  }

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
}
