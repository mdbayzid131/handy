class TodaysVerseModel {
  final String verse;
  final String reference;

  TodaysVerseModel({required this.verse, required this.reference});
}

class NextServiceModel {
  final String title;
  final String schedule;
  final String label;

  NextServiceModel({
    required this.title,
    required this.schedule,
    required this.label,
  });
}

class LatestSermonModel {
  final String series;
  final String title;
  final String preacher;
  final String duration;

  LatestSermonModel({
    required this.series,
    required this.title,
    required this.preacher,
    required this.duration,
  });
}

class HomeAnnouncementModel {
  final bool isImportant;
  final String title;
  final String description;
  final String date;

  HomeAnnouncementModel({
    required this.isImportant,
    required this.title,
    required this.description,
    required this.date,
  });
}

class HomeDataModel {
  final TodaysVerseModel todaysVerse;
  final NextServiceModel nextService;
  final LatestSermonModel latestSermon;
  final List<HomeAnnouncementModel> announcements;

  HomeDataModel({
    required this.todaysVerse,
    required this.nextService,
    required this.latestSermon,
    required this.announcements,
  });
}
