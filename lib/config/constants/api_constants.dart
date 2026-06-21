class ApiConstants {
  // Base URLs
  // static const String baseUrl = 'https://urgent-methods-special-tiger.trycloudflare.com/api/v1';
  static const String baseUrl = 'https://church-app-ooku.onrender.com/api/v1';
  // static const String apiVersion = '/api/v1';

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/user/register';
  static const String signup = '/auth/signup';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forget-password';

  // Notifications
  static const String saveFcmToken = '/notifications/save-token';

  // User Endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/update';
  static const String deleteAccount = '/user/delete-account';

  // Add your API endpoints here
  static const String resendVerifyEmail = '/auth/resend-verify-email';
  static const String verifyEmail = '/auth/verify-email';
  static const String resetPassword = '/auth/reset-password';
  static const String changePassword = '/auth/change-password';

  //products
  static const String products = '/product';

  // Sermons
  static const String sermons = '/sermons';
  static const String latestSermons = '/sermons/latest';
  static const String sermonCategories = '/sermon-category';

  // Additional Profile Endpoints
  static const String favoriteSermons = '/user/profile/favorite-sermons';

  // Giving
  static const String givingProfileSummary = '/giving/profile-summary';
  static const String givingTotalThisYear = '/giving/total-this-year';
  static const String givingFunds = '/giving/funds';
  static const String givingRecord = '/giving/record';
  static const String givingBankDetails = '/giving/bank-details';
  static const String givingHistory = '/giving/history';
  //Events
  static const String events = '/events';
  static const String latestEvents = '/events/latest';
  static const String eventsCategories = '/events/categories';
  static const String eventsHistory = '/events/history';
  static String eventDetails(String id) => '/events/$id';
  static String eventRsvp(String id) => '/events/$id/rsvp';

  // Church Info
  static const String contactAndMission = '/church-info/contact-and-mission';

  // Devotionals
  static const String devotionalsProfileSummary =
      '/devotionals/profile-summary';
  static const String devotionalsList = '/devotionals';
  static const String devotionalToday = '/devotionals/today';
  static String devotionalById(String id) => '/devotionals/$id';
  static String markDevotionalRead(String id) => '/devotionals/$id/read';

  // Community
  static const String communityList = '/community';

  // Church Info
  static const String churchInfo = '/church-info';

  // Watch Live
  static const String youtubeStatus = '/watch-live/youtube/status';
  static const String youtubeRecent = '/watch-live/youtube/recent';
  static const String youtubeChannel = '/watch-live/youtube/channel';
  static const String serviceInfo = '/watch-live/service-info';
  static const String watchLivePlatforms = '/watch-live/platforms';

  // Bible
  static const String bibleVersions = '/bible/versions';
  static const String bibleBooks = '/bible/books';

  // Prayer Wall
  static const String prayerRequests = '/prayer/requests';
  static const String myPrayerRequests = '/prayer/requests/mine';
  static String prayForRequest(String id) => '/prayer/requests/$id/pray';
}
