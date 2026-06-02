import 'package:get/get.dart';
import 'package:handy/modules/events/bindings/events_binding.dart';
import 'package:handy/modules/events/views/events_view.dart';
import 'package:handy/modules/give/bindings/give_binding.dart';
import 'package:handy/modules/give/views/give_view.dart';
import 'package:handy/modules/more/bindings/more_binding.dart';
import 'package:handy/modules/more/views/more_view.dart';
import 'package:handy/modules/news/bindings/news_binding.dart';
import 'package:handy/modules/news/views/news_view.dart';
import 'package:handy/modules/sermons/bindings/sermons_binding.dart';
import 'package:handy/modules/sermons/views/sermons_view.dart';
import '../../core/middleware/auth_middleware.dart';
import '../../core/widgets/screens/no_internet_screen.dart';
import '../../modules/auth/bindings/auth_binding.dart';
import '../../modules/auth/views/login_view.dart';
import '../../modules/auth/views/register_view.dart';
import '../../modules/auth/views/forgot_password_view.dart';
import '../../modules/bottom_nab_bar/bindings/bottom_nab_bar_binding.dart';
import '../../modules/bottom_nab_bar/views/bottom_nab_bar_view.dart';
import '../../modules/home/bindings/home_binding.dart';
import '../../modules/home/views/home_view.dart';
import '../../modules/profile/bindings/profile_binding.dart';
import '../../modules/profile/views/profile_view.dart';
import '../../modules/splash/bindings/splash_binding.dart';
import '../../modules/splash/views/splash_view.dart';
import '../../modules/search/bindings/search_binding.dart';
import '../../modules/search/views/search_view.dart';
import '../../modules/settings/bindings/settings_binding.dart';
import '../../modules/settings/views/settings_view.dart';

/// ===================== APP ROUTES =====================
/// All named route constants. Use these instead of hardcoding route strings.
abstract class AppRoutes {
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  static const String FORGOT_PASSWORD = '/forgot-password';
  static const String HOME = '/home';
  static const String PROFILE = '/profile';
  static const String BOTTOM_NAV_BAR = '/bottom-nav-bar';
  static const String SEARCH = '/search';
  static const String SETTINGS = '/settings';
  static const String NO_INTERNET = '/no-internet';
  static const String LOCK = '/lock';
  static const String SERMONS = '/sermons';
  static const String NEWS = '/news';
  static const String GIVE = '/give';
  static const String EVENTS = '/events';
  static const String MORE = '/more';
}

/// ===================== APP PAGES =====================
/// Route-to-page mapping with bindings and middleware.
final List<GetPage> pages = [
  // ─── Public Routes ───
  GetPage(
    name: AppRoutes.SPLASH,
    page: () => const SplashView(),
    binding: SplashBinding(),
  ),
  // GetPage(
  //   name: AppRoutes.LOGIN,
  //   page: () => const LoginView(),
  //   binding: AuthBinding(),
  // ),
  // GetPage(
  //   name: AppRoutes.REGISTER,
  //   page: () => const RegisterView(),
  //   binding: AuthBinding(),
  // ),
  // GetPage(
  //   name: AppRoutes.FORGOT_PASSWORD,
  //   page: () => const ForgotPasswordView(),
  //   binding: AuthBinding(),
  // ),
  GetPage(name: AppRoutes.NO_INTERNET, page: () => const NoInternetScreen()),

  // ─── Protected Routes (require authentication) ───
  GetPage(
    name: AppRoutes.BOTTOM_NAV_BAR,
    page: () => const BottomNavBarView(),
    binding: BottomNavBarBinding(),
    // middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.HOME,
    page: () => const HomeView(),
    binding: HomeBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.PROFILE,
    page: () => const ProfileView(),
    binding: ProfileBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.SEARCH,
    page: () => const SearchView(),
    binding: SearchBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.SETTINGS,
    page: () => const SettingsView(),
    binding: SettingsBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.SERMONS,
    page: () => const SermonsView(),
    binding: SermonsBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.NEWS,
    page: () => const NewsView(),
    binding: NewsBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.GIVE,
    page: () => const GiveView(),
    binding: GiveBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.EVENTS,
    page: () => const EventsView(),
    binding: EventsBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.MORE,
    page: () => const MoreView(),
    binding: MoreBinding(),
    middlewares: [AuthMiddleware()],
  ),
];
