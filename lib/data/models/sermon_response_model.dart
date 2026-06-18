class PaginationModel {
  int? page;
  int? limit;
  int? total;
  int? totalPages;
  bool? hasNextPage;

  PaginationModel({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
    this.hasNextPage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPages: json['total_pages'],
      hasNextPage: json['has_next_page'],
    );
  }
}

class CategoryModel {
  String? id;
  String? name;
  String? description;
  String? coverImageUrl;
  int? sermonCount;

  CategoryModel({
    this.id,
    this.name,
    this.description,
    this.coverImageUrl,
    this.sermonCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      description: json['description'],
      coverImageUrl: json['cover_image_url'],
      sermonCount: json['sermonCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'cover_image_url': coverImageUrl,
      'sermonCount': sermonCount,
    };
  }
}

class SermonModel {
  String? id;
  String? sId;
  String? title;
  String? speaker;
  String? date;
  int? durationSeconds;
  String? audioUrl;
  String? videoUrl;
  String? thumbnailUrl;
  String? shareUrl;
  String? keyScripture;
  String? description;
  List<String>? tags;
  String? createdAt;
  String? updatedAt;
  int? v;
  CategoryModel? category;

  SermonModel({
    this.id,
    this.sId,
    this.title,
    this.speaker,
    this.date,
    this.durationSeconds,
    this.audioUrl,
    this.videoUrl,
    this.thumbnailUrl,
    this.shareUrl,
    this.keyScripture,
    this.description,
    this.tags,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.category,
  });

  factory SermonModel.fromJson(Map<String, dynamic> json) {
    return SermonModel(
      sId: json['_id'],
      title: json['title'],
      speaker: json['speaker'],
      date: json['date'],
      durationSeconds: json['duration_seconds'],
      audioUrl: json['audio_url'],
      videoUrl: json['video_url'],
      thumbnailUrl: json['thumbnail_url'],
      shareUrl: json['share_url'],
      keyScripture: json['key_scripture'],
      description: json['description'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      category: json['category'] != null
          ? (json['category'] is String
                ? CategoryModel(id: json['category'], name: 'Unknown Category')
                : CategoryModel.fromJson(json['category']))
          : null,
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'title': title,
      'speaker': speaker,
      'date': date,
      'duration_seconds': durationSeconds,
      'audio_url': audioUrl,
      'video_url': videoUrl,
      'thumbnail_url': thumbnailUrl,
      'share_url': shareUrl,
      'key_scripture': keyScripture,
      'description': description,
      'tags': tags,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'category': category?.toJson(),
      'id': id,
    };
  }
}

class SermonListResponseModel {
  bool? success;
  int? statusCode;
  String? message;
  SermonListData? data;

  SermonListResponseModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory SermonListResponseModel.fromJson(Map<String, dynamic> json) {
    return SermonListResponseModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null ? SermonListData.fromJson(json['data']) : null,
    );
  }
}

class SermonListData {
  List<SermonModel>? data;
  PaginationModel? pagination;

  SermonListData({this.data, this.pagination});

  factory SermonListData.fromJson(Map<String, dynamic> json) {
    return SermonListData(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => SermonModel.fromJson(i)).toList()
          : null,
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'])
          : null,
    );
  }
}

class SermonDetailResponseModel {
  bool? success;
  String? message;
  SermonModel? data;

  SermonDetailResponseModel({this.success, this.message, this.data});

  factory SermonDetailResponseModel.fromJson(Map<String, dynamic> json) {
    return SermonDetailResponseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? SermonModel.fromJson(json['data']) : null,
    );
  }
}

class CategoryResponseModel {
  bool? success;
  String? message;
  List<CategoryModel>? data;

  CategoryResponseModel({this.success, this.message, this.data});

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoryResponseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
                .map((i) => CategoryModel.fromJson(i))
                .toList()
          : null,
    );
  }
}
