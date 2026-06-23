import 'package:dio/dio.dart';

import '../../config/constants/api_constants.dart';
import '../../core/services/api_client.dart';

class AuthRepo {
  final ApiClient apiClient;
  AuthRepo({required this.apiClient});

  /// ===================== DEVICE INIT =====================
  Future<Response> deviceInit({
    required String deviceId,
    required String fcmToken,
    required String platform,
  }) async {
    return await apiClient.postData(ApiConstants.deviceInit, {
      "deviceId": deviceId,
      "fcmToken": fcmToken,
      "platform": platform,
    });
  }

  /// ===================== DEVICE TOKEN REGISTRATION =====================
  Future<Response> registerDeviceToken({
    required String token,
    required String deviceType,
  }) async {
    return await apiClient.postData(ApiConstants.deviceToken, {
      "token": token,
      "deviceType": deviceType,
    });
  }

  /// ===================== REGISTER =====================
  Future<Response> register({
    required String name,
    required String email,
    required String password,
    required String deviceId,
  }) async {
    return await apiClient.postData(ApiConstants.register, {
      "name": name,
      "email": email,
      "password": password,
      "deviceId": deviceId,
    });
  }

  /// ===================== SIGNUP =====================
  Future<Response> signup({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String country,
    String role = "PARENT",
  }) async {
    return await apiClient.postData(ApiConstants.signup, {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "country": country,
      "role": role,
    });
  }

  /// ===================== LOGIN =====================
  Future<Response> login({
    required String email,
    required String password,
    required String deviceId,
  }) async {
    return await apiClient.postData(ApiConstants.login, {
      "email": email,
      "password": password,
      "deviceId": deviceId,
    });
  }

  /// ===================== FORGOT PASSWORD =====================
  Future<Response> forgotPassword({required String email}) async {
    return await apiClient.postData(ApiConstants.forgotPassword, {
      "email": email,
    });
  }

  /// ===================== RESEND OTP =====================
  Future<Response> resentOtp({required String email}) async {
    return await apiClient.postData(ApiConstants.resendVerifyEmail, {
      "email": email,
    });
  }

  /// ===================== OTP VERIFY =====================
  Future<Response> otpVerify({
    required String email,
    required int oneTimeCode,
  }) async {
    return await apiClient.postData(ApiConstants.verifyEmail, {
      "email": email,
      "oneTimeCode": oneTimeCode,
    });
  }

  /// ===================== RESET PASSWORD =====================
  Future<Response> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await apiClient.postData(
      ApiConstants.resetPassword, 
      {
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      },
      extraHeaders: {
        "Authorization": token
      }
    );
  }

  /// ===================== LOGOUT =====================
  Future<Response> logout() async {
    return await apiClient.postData(ApiConstants.logout, {});
  }

  /// ===================== REFRESH TOKEN =====================
  Future<Response> refreshToken(String refreshToken) async {
    return await apiClient.postData(ApiConstants.refreshToken, {
      "refreshToken": refreshToken,
    });
  }

  /// ===================== CHANGE PASSWORD =====================
  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await apiClient.postData(ApiConstants.changePassword, {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    });
  }
}
