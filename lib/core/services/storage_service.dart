import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ===================== STORAGE SERVICE =====================
/// Type-safe wrapper around SharedPreferences.
/// Caches the SharedPreferences instance to avoid repeated async lookups.
class StorageService extends GetxService {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //===========================> Get Data <========================
  static Future<String> getString(String key) async {
    return _preferences.getString(key) ?? "";
  }

  static Future<bool?> getBool(String key) async {
    return _preferences.getBool(key);
  }

  static Future<int> getInt(String key) async {
    return _preferences.getInt(key) ?? -1;
  }

  static Future<double?> getDouble(String key) async {
    return _preferences.getDouble(key);
  }

  static Future<List<String>?> getStringList(String key) async {
    return _preferences.getStringList(key);
  }

  //=============================> Save Data <========================
  static Future<bool> setString(String key, String value) async {
    return _preferences.setString(key, value);
  }

  static Future<bool> setBool(String key, bool value) async {
    return _preferences.setBool(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    return _preferences.setInt(key, value);
  }

  static Future<bool> setDouble(String key, double value) async {
    return _preferences.setDouble(key, value);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    return _preferences.setStringList(key, value);
  }

  //===============================> Remove Value <==================================
  static Future<bool> remove(String key) async {
    return _preferences.remove(key);
  }

  //==============================> Clear All <============================
  static Future<bool> clearAll() async {
    return _preferences.clear();
  }

  //==============================> Check Key Exists <============================
  static Future<bool> containsKey(String key) async {
    return _preferences.containsKey(key);
  }
}
