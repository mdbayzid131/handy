import 'package:get/get.dart';
import 'package:handy/data/models/home_model.dart';

import 'package:handy/config/constants/image_paths.dart';

class HomeController extends GetxController {
  final expandedIndex = (-1).obs;
  final devotionalProgress = 0.obs;

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
