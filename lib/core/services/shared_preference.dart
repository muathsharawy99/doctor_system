import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setValue(String key, var value) async {
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    }
  }

  static dynamic getValue(String key) {
    return prefs.get(key);
  }

  static Future<void> clear() => prefs.clear();
}

class AppCached {
  static String user = "user";

  /// Where the old app kept the session (read once to migrate it).
  static String legacyToken = 'userToken';
  static String legacyName = 'userName';
  static String legacyPassword = 'userPassword';
  static String legacyType = 'userType';
  static String legacyTitle = 'userTitle';
  static String legacyAddress = 'userAddress';
}
