class SermonCategoryResponse {
  final bool? success;
  final String? message;
  final List<SermonCategory>? data;

  SermonCategoryResponse({this.success, this.message, this.data});

  factory SermonCategoryResponse.fromJson(Map<String, dynamic> json) {
    return SermonCategoryResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
                .map((i) => SermonCategory.fromJson(i))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class SermonCategory {
  final String? sId;
  final String? name;
  final String? description;
  final String? coverImageUrl;
  final String? createdAt;
  final String? updatedAt;
  final int? iV;
  final int? sermonCount;
  final String? id;

  SermonCategory({
    this.sId,
    this.name,
    this.description,
    this.coverImageUrl,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.sermonCount,
    this.id,
  });

  factory SermonCategory.fromJson(Map<String, dynamic> json) {
    return SermonCategory(
      sId: json['_id'],
      name: json['name'],
      description: json['description'],
      coverImageUrl: json['cover_image_url'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
      sermonCount: json['sermonCount'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'name': name,
      'description': description,
      'cover_image_url': coverImageUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
      'sermonCount': sermonCount,
      'id': id,
    };
  }
}
