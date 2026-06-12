import 'package:get/get.dart';
import 'package:handy/data/models/events_model.dart';
import 'package:handy/data/models/home_model.dart';
import 'package:handy/data/models/contact_mission_model.dart';
import 'package:handy/config/constants/image_paths.dart';
import 'package:handy/core/services/storage_service.dart';

import 'package:handy/core/services/api_client.dart';
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
    fetchDevotionalSummary();
  }

  Future<void> fetchDevotionalSummary() async {
    isLoadingDevotional.value = true;
    try {
      final response = await apiClient.getData(ApiConstants.devotionalsProfileSummary);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          devotionalProgress.value = response.data['data']['weekly_progress'] ?? 0;
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
          latestEvents.value = data.map((e) => EventModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
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
        if (response.data['data'] != null &&
            (response.data['data'] as List).isNotEmpty) {
          latestSermon.value = LatestSermonModel.fromJson(
            response.data['data'][0],
          );
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching latest sermon: $e');
    } finally {
      isLoadingSermon.value = false;
    }
  }

  Future<void> refreshHome() async {
    await fetchLatestSermon();
    await fetchLatestEvents();
    await fetchContactAndMission();
    await fetchDevotionalSummary();
  }

  Future<void> _loadProgress() async {
    int value = await StorageService.getInt('devotionalProgress');
    devotionalProgress.value = value == -1 ? 0 : value;
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

  final HomeDataModel homeData = HomeDataModel(
    todaysVerse: TodaysVerseModel(
      verse: '"I can do all things through him who strengthens me."',
      reference: '— Philippians 4:13',
    ),
    nextService: NextServiceModel(
      label: 'NEXT SERVICE',
      title: 'Sunday Worship',
      schedule: 'Sunday · 10:00 AM – 12:30 PM',
    ),
    latestSermon: LatestSermonModel(
      id: '1',
      series: 'WALKING IN FAITH',
      title: 'The Anchor of Hope',
      preacher: 'Pastor Emmanuel Asante',
      duration: '42 min',
    ),
    announcements: [
      HomeAnnouncementModel(
        isImportant: true,
        title: 'Sunday Service — This Week',
        description:
            'Join us this Sunday at 71 Stoneyburn Street. Service runs from 10:00 AM to 12:30 PM. All are ...',
        date: 'May 5, 2026',
        imageUrl: ImagePaths.service1,
      ),
      HomeAnnouncementModel(
        isImportant: false,
        title: 'Baptism Sunday — Register Now',
        description:
            'If you\'re ready to take the step of water baptism, please speak with any of our elders or pastors. B...',
        date: 'May 4, 2026',
        imageUrl: ImagePaths.service1,
      ),
    ],
  );
}
