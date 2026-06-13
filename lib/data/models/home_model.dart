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
