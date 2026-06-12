class BibleBook {
  final String? id;
  final String? name; // We will use abbreviation or id as name if name is not returned
  final String? abbreviation;
  final String? testament;
  final int chaptersCount;
  final bool isOldTestament;

  BibleBook({
    this.id,
    this.name,
    this.abbreviation,
    this.testament,
    required this.chaptersCount,
    required this.isOldTestament,
  });

  factory BibleBook.fromJson(Map<String, dynamic> json) {
    return BibleBook(
      id: json['id'],
      name: json['abbreviation'] ?? json['id'], // Assuming we use abbreviation for display name
      abbreviation: json['abbreviation'],
      testament: json['testament'],
      chaptersCount: json['chapters_count'] ?? 0,
      isOldTestament: json['testament'] == 'OT',
    );
  }
}

class BibleVersionModel {
  final int? id;
  final String? name;
  final String? abbreviation;
  final bool? isActive;
  final String? sId;

  BibleVersionModel({
    this.id,
    this.name,
    this.abbreviation,
    this.isActive,
    this.sId,
  });

  factory BibleVersionModel.fromJson(Map<String, dynamic> json) {
    return BibleVersionModel(
      id: json['id'],
      name: json['name'],
      abbreviation: json['abbreviation'],
      isActive: json['isActive'],
      sId: json['_id'],
    );
  }
}

class BibleVerseModel {
  final String? verseNumber;
  final String? text;

  BibleVerseModel({
    this.verseNumber,
    this.text,
  });

  factory BibleVerseModel.fromJson(Map<String, dynamic> json) {
    return BibleVerseModel(
      verseNumber: json['verse_number']?.toString(),
      text: json['text'],
    );
  }
}
