class EventModel {
  final String id;
  final String category;
  final String title;
  final String date;
  final String time;
  final String location;
  final int attendeeCount;
  final String description;

  EventModel({
    required this.id,
    required this.category,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.attendeeCount,
    required this.description,
  });
}
