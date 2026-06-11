import 'package:get/get.dart';
import 'package:handy/config/constants/api_constants.dart';
import 'package:handy/core/services/auth_service.dart';
import '../../../core/services/api_client.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/sermon_response_model.dart';
import 'package:handy/core/utils/helpers.dart';

class ProfileController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();

  final Rxn<UserModel> user = Rxn<UserModel>();
  final Rxn<GivingSummaryModel> givingSummary = Rxn<GivingSummaryModel>();
  final RxNum totalThisYear = RxNum(0);
  final RxList<SermonModel> favoriteSermons = <SermonModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final authService = Get.find<AuthService>();

    // Only fetch if already logged in
    if (authService.isLoggedIn.value) {
      fetchAllData();
    }

    // Listen to changes so profile updates when they log in later
    ever(authService.isLoggedIn, (isLoggedIn) {
      if (isLoggedIn) {
        fetchAllData();
      } else {
        user.value = null;
        givingSummary.value = null;
        totalThisYear.value = 0;
        favoriteSermons.clear();
      }
    });
  }

  Future<void> fetchAllData() async {
    isLoading.value = true;
    await Future.wait([
      fetchProfile(),
      fetchGivingSummary(),
      fetchTotalThisYear(),
      fetchFavoriteSermons(),
    ]);
    isLoading.value = false;
  }

  Future<void> fetchProfile() async {
    try {
      final response = await apiClient.getData(ApiConstants.profile);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          final data = response.data['data'];
          if (data['user'] != null) {
            user.value = UserModel.fromJson(data['user']);
          } else {
            // Fallback for old structure
            user.value = UserModel.fromJson(data);
          }
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Failed to fetch profile: $e');
    }
  }

  Future<void> fetchFavoriteSermons() async {
    try {
      final response = await apiClient.getData(
        '${ApiConstants.favoriteSermons}?limit=5',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          final sermonsList = (response.data['data'] as List)
              .map((x) => SermonModel.fromJson(x))
              .toList();
          favoriteSermons.assignAll(sermonsList);
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Failed to fetch favorite sermons: $e');
    }
  }

  Future<void> fetchGivingSummary() async {
    try {
      final response = await apiClient.getData(
        ApiConstants.givingProfileSummary,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          givingSummary.value = GivingSummaryModel.fromJson(
            response.data['data'],
          );
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Failed to fetch giving summary: $e');
    }
  }

  Future<void> fetchTotalThisYear() async {
    try {
      final response = await apiClient.getData(
        ApiConstants.givingTotalThisYear,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null &&
            response.data['data']['totalThisYear'] != null) {
          totalThisYear.value = response.data['data']['totalThisYear'];
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Failed to fetch total this year: $e');
    }
  }

  Future<void> toggleFavoriteSermon(String sermonId) async {
    // Optimistic update for UI responsiveness
    final isFav = isSermonFavorite(sermonId);
    if (isFav) {
      favoriteSermons.removeWhere(
        (sermon) => sermon.id == sermonId || sermon.sId == sermonId,
      );
    } else {
      // Just visually toggle for a split second, though we don't have the full model
      // so it's better to let the API update it
    }

    try {
      final response = await apiClient.postData(
        '${ApiConstants.favoriteSermons}/$sermonId',
        {},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          final updatedData = response.data['data'];
          if (updatedData['favoriteSermons'] != null) {
            final sermonsList = (updatedData['favoriteSermons'] as List)
                .map((x) => SermonModel.fromJson(x))
                .toList();
            favoriteSermons.assignAll(sermonsList);
          } else {
            favoriteSermons.clear();
          }
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Failed to toggle favorite sermon: $e');
      // Re-fetch on error to revert optimistic update
      fetchProfile();
    }
  }

  bool isSermonFavorite(String sermonId) {
    return favoriteSermons.any(
      (sermon) => sermon.id == sermonId || sermon.sId == sermonId,
    );
  }
}
