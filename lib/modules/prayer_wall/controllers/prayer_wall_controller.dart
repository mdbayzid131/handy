import 'package:get/get.dart';
import '../../../data/models/prayer_wall_model.dart';

class PrayerWallController extends GetxController {
  final requests = <PrayerWallModel>[].obs;
  final isAnonymous = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  void fetchRequests() {
    // Dummy data
    requests.value = [
      PrayerWallModel(
        name: 'Sister Grace',
        date: 'May 2, 2025',
        request: 'My son has been away from faith for several years. I\'m believing God for his return. Please stand with me in prayer.',
        praysCount: 41,
      ),
      PrayerWallModel(
        name: 'Anonymous',
        date: 'May 1, 2025',
        request: 'Struggling with anxiety and fear about the future. Asking for prayers for peace and trust in God\'s plan.',
        praysCount: 35,
      ),
      PrayerWallModel(
        name: 'Emmanuel F.',
        date: 'Apr 30, 2025',
        request: 'Our family is facing financial hardship. We\'re trusting God to provide, but it\'s been hard. Please pray with us.',
        praysCount: 28,
      ),
    ];
  }
}
