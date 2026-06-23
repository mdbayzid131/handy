class SocialLinkModel {
  final String? platform;
  final String? url;
  final bool? isEnabled;
  final String? id;

  SocialLinkModel({this.platform, this.url, this.isEnabled, this.id});

  factory SocialLinkModel.fromJson(Map<String, dynamic> json) {
    return SocialLinkModel(
      platform: json['platform'],
      url: json['url'],
      isEnabled: json['isEnabled'],
      id: json['_id'],
    );
  }
}

class ContactMissionModel {
  final String? address;
  final String? sundayService;
  final String? email;
  final String? website;
  final String? ourMission;
  final List<SocialLinkModel>? socialLinks;

  ContactMissionModel({
    this.address,
    this.sundayService,
    this.email,
    this.website,
    this.ourMission,
    this.socialLinks,
  });

  factory ContactMissionModel.fromJson(Map<String, dynamic> json) {
    var list = json['social_links'] as List?;
    List<SocialLinkModel>? socialLinksList =
        list?.map((i) => SocialLinkModel.fromJson(i)).toList();

    return ContactMissionModel(
      address: json['address'],
      sundayService: json['sunday_service'],
      email: json['email'],
      website: json['website'],
      ourMission: json['our_mission'],
      socialLinks: socialLinksList,
    );
  }
}
