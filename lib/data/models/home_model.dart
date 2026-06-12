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
  final String id;
  final String series;
  final String title;
  final String preacher;
  final String duration;
  final String? thumbnailUrl;

  LatestSermonModel({
    required this.id,
    required this.series,
    required this.title,
    required this.preacher,
    required this.duration,
    this.thumbnailUrl,
  });

  factory LatestSermonModel.fromJson(Map<String, dynamic> json) {
    String formattedDuration = '';
    if (json['duration_seconds'] != null) {
      int seconds = json['duration_seconds'];
      int minutes = seconds ~/ 60;
      formattedDuration = '$minutes min';
    }
    return LatestSermonModel(
      id: json['_id'] ?? json['id'] ?? '',
      series: json['category'] != null ? json['category']['name'] ?? 'Sermon' : 'Sermon',
      title: json['title'] ?? '',
      preacher: json['speaker'] ?? '',
      duration: formattedDuration,
      thumbnailUrl: json['thumbnail_url'],
    );
  }
}

class HomeAnnouncementModel {
  final bool isImportant;
  final String title;
  final String description;
  final String date;
  final String? imageUrl;

  HomeAnnouncementModel({
    required this.isImportant,
    required this.title,
    required this.description,
    required this.date,
    this.imageUrl,
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
