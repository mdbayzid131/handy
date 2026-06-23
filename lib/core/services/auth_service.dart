import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart' hide Response;
import 'package:uuid/uuid.dart';
import 'package:handy/config/routes/app_pages.dart';
import 'package:handy/core/services/storage_service.dart';
import 'package:handy/core/utils/logger.dart';
import '../../config/constants/storage_constants.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/models/user_model.dart';
import 'api_client.dart';

/// ===================== AUTH SERVICE =====================
/// Manages all authentication flows: login, signup, logout,
/// password reset, OTP verification, and token persistence.
class AuthService extends GetxService {
  late final AuthRepo _authRepo;

  /// Observable login state — use this in UI bindings
  final isLoggedIn = false.obs;

  /// Observable current user data
  final currentUser = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    _authRepo = AuthRepo(apiClient: Get.find<ApiClient>());
    _checkLoginStatus();
  }

  // ──────────────────── AUTH STATE ────────────────────

  Future<void> _checkLoginStatus() async {
    final bool isLogged = await StorageService.getBool(StorageConstants.isLoggedIn) ?? false;
    isLoggedIn.value = isLogged;
  }

  /// Check if user is authenticated
  bool get isAuthenticated => isLoggedIn.value;

  // ──────────────────── DEVICE INIT (GUEST) ────────────────────

  Future<String> getOrCreateDeviceId() async {
    String deviceId = await StorageService.getString(StorageConstants.deviceId);
    if (deviceId.isEmpty) {
      deviceId = const Uuid().v4();
      await StorageService.setString(StorageConstants.deviceId, deviceId);
    }
    return deviceId;
  }

  Future<void> initDevice() async {
    try {
      final deviceId = await getOrCreateDeviceId();
      String fcmToken = await FirebaseMessaging.instance.getToken() ?? 'unknown';
      final platform = Platform.isAndroid ? 'android' : (Platform.isIOS ? 'ios' : 'web');

      final response = await _authRepo.deviceInit(
        deviceId: deviceId,
        fcmToken: fcmToken,
        platform: platform,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await _saveAuthTokens(response, isGuest: true);
      }
    } catch (e) {
      AppLogger.debug('Device Init failed: $e');
    }
  }

  // ──────────────────── REGISTER ────────────────────

  Future<Response> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final deviceId = await getOrCreateDeviceId();
    return await _authRepo.register(
      name: name,
      email: email,
      password: password,
      deviceId: deviceId,
    );
  }

  // ──────────────────── SIGNUP ────────────────────

  Future<Response> signup({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String country,
  }) async {
    return await _authRepo.signup(
      name: name,
      email: email,
      password: password,
      phone: phone,
      country: country,
    );
  }

  // ──────────────────── LOGIN ────────────────────

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    final deviceId = await getOrCreateDeviceId();
    return await _authRepo.login(
      email: email, 
      password: password,
      deviceId: deviceId,
    );
  }

  // ──────────────────── CHANGE PASSWORD ────────────────────

  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await _authRepo.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }

  // ──────────────────── LOGOUT ────────────────────

  Future<void> logout({bool localOnly = false}) async {
    try {
      if (!localOnly) {
        await _authRepo.logout();
      }
    } catch (e) {
      // Just catch and ignore errors on logout API
      AppLogger.debug('Logout API failed: $e');
    } finally {
      await clearLocalAuth();
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }

  // ──────────────────── FORGOT PASSWORD ────────────────────

  Future<Response> forgotPassword(String email) async {
    return await _authRepo.forgotPassword(email: email);
  }

  // ──────────────────── OTP VERIFY ────────────────────

  Future<Response> verifyOtp({
    required String email,
    required int otp,
    bool isForgotPassword = false,
  }) async {
    final response = await _authRepo.otpVerify(email: email, oneTimeCode: otp);

    // If OTP verification logs the user in directly (not for forgot password)
    if (!isForgotPassword) {
      await _saveAuthTokens(response);
    }
    return response;
  }

  // ──────────────────── RESEND OTP ────────────────────

  Future<void> resendOtp(String email) async {
    await _authRepo.resentOtp(email: email);
  }

  // ──────────────────── RESET PASSWORD ────────────────────

  Future<Response> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await _authRepo.resetPassword(
      token: token,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }

  // ──────────────────── TOKEN HELPERS ────────────────────

  /// Save auth tokens from API response.
  /// Public so controllers can call it after social login etc.
  Future<void> _saveAuthTokens(Response response, {bool isGuest = false}) async {
    final data = response.data;
    final authData = data is Map ? (data['data'] ?? data) : data;

    if (authData is! Map) return;

    final accessToken = authData['accessToken'] ?? authData['token'];
    final refreshToken = authData['refreshToken'];

    if (accessToken != null) {
      await StorageService.setString(
        StorageConstants.bearerToken,
        accessToken.toString(),
      );
      if (!isGuest) {
        isLoggedIn.value = true;
        await StorageService.setBool(StorageConstants.isLoggedIn, true);
      }
    }

    if (refreshToken != null) {
      await StorageService.setString(
        StorageConstants.refreshToken,
        refreshToken.toString(),
      );
    }
  }

  /// Handles successful auth response from external callers
  Future<void> handleAuthResponse(Response response) async {
    await _saveAuthTokens(response);
  }

  /// Clear all local auth data without routing
  Future<void> clearLocalAuth() async {
    await StorageService.remove(StorageConstants.bearerToken);
    await StorageService.remove(StorageConstants.refreshToken);
    await StorageService.remove(StorageConstants.userData);
    await StorageService.setBool(StorageConstants.isLoggedIn, false);
    isLoggedIn.value = false;
    currentUser.value = null;
  }
}
