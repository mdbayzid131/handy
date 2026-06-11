import 'package:get/get.dart';
import 'package:handy/core/utils/helpers.dart';
import '../../../data/models/sermon_response_model.dart';
import '../../../core/services/api_client.dart';
import '../../../core/services/api_checker.dart';
import 'package:handy/config/constants/api_constants.dart';

class SermonDitailsController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();

  SermonDitailsController();

  final RxString sermonId = ''.obs;
  final Rxn<SermonModel> sermonDetail = Rxn<SermonModel>();
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    String id = '';

    if (args is String) {
      id = args;
    } else if (args is SermonModel) {
      if (args.sId != null) {
        id = args.sId!;
      } else if (args.id != null) {
        id = args.id!;
      }
      sermonDetail.value = args;
    } else if (args != null && args is Map && args['id'] != null) {
      id = args['id'];
    }

    if (id.isNotEmpty) {
      sermonId.value = id;
      fetchSermonDetail(id);
    } else {
      isLoading.value = false;
      Helpers.showDebugLog('Sermon ID is missing');
    }
  }

  Future<void> fetchSermonDetail(String id) async {
    isLoading.value = true;
    try {
      final response = await apiClient.getData('${ApiConstants.sermons}/$id');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = SermonDetailResponseModel.fromJson(response.data);
        if (result.success == true && result.data != null) {
          sermonDetail.value = result.data!;
        }
      } else {
        ApiChecker.checkGetApi(response);
      }
    } catch (e) {
      Helpers.showDebugLog('Failed to load sermon detail: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    final id = sermonDetail.value?.sId ?? sermonDetail.value?.id;
    if (id != null) {
      await fetchSermonDetail(id);
    }
  }
}
