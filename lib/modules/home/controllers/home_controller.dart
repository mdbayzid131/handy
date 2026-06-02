import 'package:get/get.dart';
import '../../../config/constants/api_constants.dart';
import '../../../core/services/api_client.dart';

class HomeController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () => isLoading.value = false);
  }

  fetchProducts() async {
    try {
      isLoading.value = true;
      final response = await _apiClient.getData(ApiConstants.products);

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
