class ContactMissionModel {
  final String? address;
  final String? sundayService;
  final String? email;
  final String? website;
  final String? ourMission;

  ContactMissionModel({
    this.address,
    this.sundayService,
    this.email,
    this.website,
    this.ourMission,
  });

  factory ContactMissionModel.fromJson(Map<String, dynamic> json) {
    return ContactMissionModel(
      address: json['address'],
      sundayService: json['sunday_service'],
      email: json['email'],
      website: json['website'],
      ourMission: json['our_mission'],
    );
  }
}
