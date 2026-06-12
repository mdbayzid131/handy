import 'package:intl/intl.dart';

class PrayerWallModel {
  final String id;
  final String name;
  final String date;
  final String request;
  final int praysCount;

  PrayerWallModel({
    required this.id,
    required this.name,
    required this.date,
    required this.request,
    required this.praysCount,
  });

  factory PrayerWallModel.fromJson(Map<String, dynamic> json) {
    String formattedDate = '';
    if (json['createdAt'] != null) {
      try {
        final date = DateTime.parse(json['createdAt']);
        formattedDate = DateFormat('MMM d, yyyy').format(date);
      } catch (e) {
        formattedDate = json['createdAt'].toString();
      }
    }

    return PrayerWallModel(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['author_name'] ?? 'Anonymous',
      date: formattedDate,
      request: json['content'] ?? '',
      praysCount: json['pray_count'] ?? 0,
    );
  }
}
