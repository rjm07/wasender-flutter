import 'package:shared_preferences/shared_preferences.dart';

class LocalPrefs {
  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LocalPrefKeys.token);
  }

  static Future<String?> getBearerToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LocalPrefKeys.bearerToken);
  }

  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_LocalPrefKeys.token, token);
    prefs.setString(_LocalPrefKeys.bearerToken, token);
  }

  static Future<void> clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_LocalPrefKeys.token);
    prefs.remove(_LocalPrefKeys.bearerToken);
  }

  static Future<String?> getDeviceKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LocalPrefKeys.deviceKey); // pkey on device list primary device
  }

  static Future<void> saveDeviceKey(String deviceKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_LocalPrefKeys.deviceKey, deviceKey);
  }

  static Future<void> clearDeviceKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_LocalPrefKeys.deviceKey);
  }
}

class _LocalPrefKeys {
  static String token = "TOKEN_VALUE";
  static String bearerToken = "Bearer $token";
  static String deviceKey = "DEVICE_KEY";
}

// class LocalPrefs {
//   static Future<String?> getBrandId() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_LocalPrefKeys.brandId);
//   }
//
//   static Future<void> saveBrandId(String brandId) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString(_LocalPrefKeys.brandId, brandId);
//   }
//
//   static Future<void> clearBrandId() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove(_LocalPrefKeys.brandId);
//   }
// }
//
// class _LocalPrefKeys {
//   static String brandId = "BRAND_ID";
// }
