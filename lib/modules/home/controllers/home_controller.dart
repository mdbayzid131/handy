import 'package:get/get.dart';
import 'package:handy/data/models/events_model.dart';
import 'package:handy/data/models/home_model.dart';
import 'package:handy/data/models/contact_mission_model.dart';
import 'package:handy/core/services/storage_service.dart';

import 'package:handy/core/services/api_client.dart';
import 'package:handy/core/services/auth_service.dart';
import 'package:handy/core/utils/helpers.dart';
import 'package:handy/config/constants/api_constants.dart';

class HomeController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();

  final expandedIndex = (-1).obs;
  final devotionalProgress = 0.obs;

  final isLoadingSermon = false.obs;
  final latestSermon = Rxn<LatestSermonModel>();

  final isLoadingEvents = false.obs;
  final latestEvents = <EventModel>[].obs;

  final isLoadingContact = false.obs;
  final contactMission = Rxn<ContactMissionModel>();

  final isLoadingDevotional = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLatestSermon();
    fetchLatestEvents();
    fetchContactAndMission();
    
    // Only fetch user-specific data if logged in
    if (Get.find<AuthService>().isLoggedIn.value) {
      fetchDevotionalSummary();
    }
  }

  Future<void> fetchDevotionalSummary() async {
    isLoadingDevotional.value = true;
    try {
      final response = await apiClient.getData(ApiConstants.devotionalsProfileSummary);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          int weekly = response.data['data']['weekly_progress'] ?? 0;
          int streak = response.data['data']['devotionals_streak_days'] ?? 0;
          // Fallback to streak if weekly_progress is not updating properly from backend
          devotionalProgress.value = weekly > 0 ? weekly : (streak > 7 ? streak % 7 : streak);
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching devotional summary: $e');
    } finally {
      isLoadingDevotional.value = false;
    }
  }

  Future<void> fetchContactAndMission() async {
    isLoadingContact.value = true;
    try {
      final response = await apiClient.getData(ApiConstants.contactAndMission);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          contactMission.value = ContactMissionModel.fromJson(response.data['data']);
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching contact & mission: $e');
    } finally {
      isLoadingContact.value = false;
    }
  }

  Future<void> fetchLatestEvents() async {
    isLoadingEvents.value = true;
    try {
      final response = await apiClient.getData(
        '${ApiConstants.latestEvents}?limit=2',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null && response.data['data'] is List) {
          final List data = response.data['data'];
          if (data.isNotEmpty) {
            latestEvents.value = data.map((e) => EventModel.fromJson(e)).toList();
          } else {
            latestEvents.clear();
          }
        } else {
          latestEvents.clear();
        }
      } else {
        latestEvents.clear();
      }
    } catch (e) {
      latestEvents.clear();
      Helpers.showDebugLog('Error fetching latest events: $e');
    } finally {
      isLoadingEvents.value = false;
    }
  }

  Future<void> fetchLatestSermon() async {
    isLoadingSermon.value = true;
    try {
      final response = await apiClient.getData(ApiConstants.latestSermons);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];
        if (data != null && data is List && data.isNotEmpty) {
          final item = data[0];
          if (item != null && item is Map && (item['_id'] != null || item['id'] != null)) {
            latestSermon.value = LatestSermonModel.fromJson(item as Map<String, dynamic>);
          } else {
            latestSermon.value = null;
          }
        } else {
          latestSermon.value = null;
        }
      } else {
        latestSermon.value = null;
      }
    } catch (e) {
      latestSermon.value = null;
      Helpers.showDebugLog('Error fetching latest sermon: $e');
    } finally {
      isLoadingSermon.value = false;
    }
  }

  Future<void> refreshHome() async {
    await fetchLatestSermon();
    await fetchLatestEvents();
    await fetchContactAndMission();
    if (Get.find<AuthService>().isLoggedIn.value) {
      await fetchDevotionalSummary();
    }
  }

  void toggleExpanded(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }

  void incrementDevotionalProgress() {
    if (devotionalProgress.value < 7) {
      devotionalProgress.value++;
      StorageService.setInt('devotionalProgress', devotionalProgress.value);
    }
  }

}
