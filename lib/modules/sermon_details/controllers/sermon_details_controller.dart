import 'package:get/get.dart';
import '../../../core/services/api_client.dart';
import '../../../core/services/api_checker.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/sermon_response_model.dart';
import '../../../config/constants/api_constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SermondetailsController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();

  final RxString sermonId = ''.obs;
  final Rxn<SermonModel> sermonDetail = Rxn<SermonModel>();
  final RxBool isLoading = true.obs;

  YoutubePlayerController? youtubePlayerController;

  @override
  void onInit() {
    super.onInit();
    _extractAndFetchSermon();
  }

  void _extractAndFetchSermon() {
    final args = Get.arguments;
    String id = '';

    if (args is String) {
      id = args;
    } else if (args is SermonModel) {
      id = args.sId ?? args.id ?? '';
      sermonDetail.value = args;
      _setupVideoPlayer(args);
    } else if (args is Map && args['id'] != null) {
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
      ApiChecker.checkGetApi(response);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = SermonDetailResponseModel.fromJson(response.data);
        if (result.success == true && result.data != null) {
          sermonDetail.value = result.data!;
          _setupVideoPlayer(result.data!);
        }
      }
    } catch (e, s) {
      Helpers.showDebugLog('Failed to load sermon detail: $e\n$s');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    final id = sermonDetail.value?.sId ?? sermonDetail.value?.id ?? sermonId.value;
    if (id.isNotEmpty) {
      await fetchSermonDetail(id);
    }
  }

  void _setupVideoPlayer(SermonModel sermon) {
    final videoUrl = sermon.videoUrl ?? sermon.audioUrl;
    if (videoUrl != null && videoUrl.isNotEmpty) {
      final videoId = _extractYoutubeId(videoUrl);
      if (videoId != null) {
        youtubePlayerController?.close();
        youtubePlayerController = YoutubePlayerController.fromVideoId(
          videoId: videoId,
          autoPlay: false,
          params: const YoutubePlayerParams(showFullscreenButton: true),
        );
        update();
      }
    }
  }

  String? _extractYoutubeId(String url) {
    final RegExp regExp = RegExp(
      r'.*(?:youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*',
      caseSensitive: false,
      multiLine: false,
    );
    final match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1 && match.group(1)!.length == 11) {
      return match.group(1);
    }
    return null;
  }

  @override
  void onClose() {
    youtubePlayerController?.close();
    super.onClose();
  }
}
