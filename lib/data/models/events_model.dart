class EventCategoryModel {
  final String id;
  final String label;
  final String? color;

  EventCategoryModel({
    required this.id,
    required this.label,
    this.color,
  });

  factory EventCategoryModel.fromJson(Map<String, dynamic> json) {
    return EventCategoryModel(
      id: json['id'] ?? '',
      label: json['label'] ?? '',
      color: json['color'],
    );
  }
}

class EventModel {
  final String id;
  final String title;
  final String categoryId;
  final String category;
  final String categoryLabel;
  final String? categoryColor;
  final String date;
  final String dateISO;
  final String time;
  final String location;
  final int attendingCount;
  final bool hasRsvp;
  final bool isPast;
  final String? description;

  EventModel({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.category,
    required this.categoryLabel,
    this.categoryColor,
    required this.date,
    required this.dateISO,
    required this.time,
    required this.location,
    required this.attendingCount,
    required this.hasRsvp,
    required this.isPast,
    this.description,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      categoryId: json['categoryId'] ?? '',
      category: json['category'] ?? '',
      categoryLabel: json['categoryLabel'] ?? '',
      categoryColor: json['categoryColor'],
      date: json['date'] ?? '',
      dateISO: json['dateISO'] ?? '',
      time: json['time'] ?? '',
      location: json['location'] ?? '',
      attendingCount: json['attendingCount'] ?? 0,
      hasRsvp: json['hasRsvp'] ?? false,
      isPast: json['isPast'] ?? false,
      description: json['description'],
    );
  }

  EventModel copyWith({
    String? id,
    String? title,
    String? categoryId,
    String? category,
    String? categoryLabel,
    String? categoryColor,
    String? date,
    String? dateISO,
    String? time,
    String? location,
    int? attendingCount,
    bool? hasRsvp,
    bool? isPast,
    String? description,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
      categoryLabel: categoryLabel ?? this.categoryLabel,
      categoryColor: categoryColor ?? this.categoryColor,
      date: date ?? this.date,
      dateISO: dateISO ?? this.dateISO,
      time: time ?? this.time,
      location: location ?? this.location,
      attendingCount: attendingCount ?? this.attendingCount,
      hasRsvp: hasRsvp ?? this.hasRsvp,
      isPast: isPast ?? this.isPast,
      description: description ?? this.description,
    );
  }
}
