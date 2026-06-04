class CommunityModel {
  final String category;
  final String title;
  final String description;
  final String date;
  bool isJoined;

  CommunityModel(
    this.category,
    this.title,
    this.description,
    this.date, {
    this.isJoined = false,
  });

  static List<CommunityModel> dummyData = [
    CommunityModel(
      'FINANCE',
      'Building Fund Update',
      'We\'ve reached 68% of our building fund goal! Thank you for your generous giving. Together, we\'re building a home for the next generation.',
      'May 1, 2026',
    ),
    CommunityModel(
      'YOUTH',
      'Youth Night: Ignite — This Friday',
      'All teens and young adults (13–25) are invited to Ignite this Friday at 6:30 PM. Worship, games, and a powerful word. Bring your friends!',
      'Apr 30, 2026',
    ),
    CommunityModel(
      'WOMEN',
      'Women\'s Ministry Prayer Breakfast',
      'Join us for our monthly prayer breakfast. It will be a time of refreshing, fellowship, and deep prayers. Breakfast will be provided.',
      'Apr 28, 2026',
    ),
    CommunityModel(
      'MEN',
      'Men of Valor Conference 2026',
      'Registration is now open for the annual Men of Valor conference. Early bird tickets are available at the information desk.',
      'Apr 25, 2026',
    ),
    CommunityModel(
      'CHOIR',
      'Choir Rehearsal Schedule Change',
      'Please note that this week\'s choir rehearsal has been moved to Thursday at 7:00 PM instead of Wednesday. Please be on time.',
      'Apr 22, 2026',
    ),
  ];
}
