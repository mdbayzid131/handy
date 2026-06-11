class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://church-app-ooku.onrender.com/api/v1';
  // static const String apiVersion = '/api/v1';

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/user/register';
  static const String signup = '/auth/signup';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';

  // User Endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/update';

  // Add your API endpoints here
  static const String resendVerifyEmail = '/auth/resend-verify-email';
  static const String verifyEmail = '/auth/verify-email';
  static const String resetPassword = '/auth/reset-password';
  static const String changePassword = '/auth/change-password';

  //products
  static const String products = '/product';

  // Sermons
  static const String sermons = '/sermons';
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
}
