class CommunityModel {
  final String? id;
  final String? title;
  final String? description;
  final String? joinLink;
  final String? platform;
  final String? platformLabel;
  final int? sortOrder;
  final bool? isActive;
  final String? createdAt;
  bool isJoined;

  CommunityModel({
    this.id,
    this.title,
    this.description,
    this.joinLink,
    this.platform,
    this.platformLabel,
    this.sortOrder,
    this.isActive,
    this.createdAt,
    this.isJoined = false,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      joinLink: json['joinLink'],
      platform: json['platform'],
      platformLabel: json['platformLabel'],
      sortOrder: json['sortOrder'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
    );
  }
}
