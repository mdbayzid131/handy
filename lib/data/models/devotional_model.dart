class DevotionalModel {
  final String? id;
  final String? title;
  final String? dayLabel;
  final String? date;
  final String? dateISO;
  final String? scriptureRef;
  final String? scriptureQuote;
  final String? reflection;
  final String? reflectionPreview;
  final String? prayer;
  final bool? isRead;

  DevotionalModel({
    this.id,
    this.title,
    this.dayLabel,
    this.date,
    this.dateISO,
    this.scriptureRef,
    this.scriptureQuote,
    this.reflection,
    this.reflectionPreview,
    this.prayer,
    this.isRead,
  });

  factory DevotionalModel.fromJson(Map<String, dynamic> json) {
    return DevotionalModel(
      id: json['id'],
      title: json['title'],
      dayLabel: json['dayLabel'],
      date: json['date'],
      dateISO: json['dateISO'],
      scriptureRef: json['scriptureRef'],
      scriptureQuote: json['scriptureQuote'],
      reflection: json['reflection'],
      reflectionPreview: json['reflectionPreview'],
      prayer: json['prayer'],
      isRead: json['isRead'],
    );
  }
}
