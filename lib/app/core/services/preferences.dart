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

  static Future<String?> getPassBySystem() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LocalPrefKeys.passwordBySystem);
  }

  static Future<void> savePassBySystem(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_LocalPrefKeys.passwordBySystem, value);
  }

  static Future<void> clearPassBySystem() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_LocalPrefKeys.passwordBySystem);
  }

  ///MARK: Get Full Name

  static Future<String?> getFullName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LocalPrefKeys.fullName);
  }

  static Future<void> clearFullName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_LocalPrefKeys.fullName);
  }

  static Future<void> saveFullName(String fullname) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_LocalPrefKeys.fullName, fullname);
  }

  ///MARK: Get Full Name

  static Future<String?> getImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LocalPrefKeys.image);
  }

  static Future<void> clearImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_LocalPrefKeys.image);
  }

  static Future<void> saveImage(String image) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_LocalPrefKeys.image, image);
  }

  static Future<String?> getUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LocalPrefKeys.userRole); // pkey on device list primary device
  }

  static Future<void> saveUserRole(String role) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_LocalPrefKeys.userRole, role);
  }

  static Future<void> clearUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_LocalPrefKeys.userRole);
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

  static Future<String?> getFKUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LocalPrefKeys.whatsappNumber);
  }

  static Future<void> saveFKUserID(String whatsappNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_LocalPrefKeys.whatsappNumber, whatsappNumber);
  }

  static Future<void> clearFKUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_LocalPrefKeys.whatsappNumber);
  }

  static Future<String?> getWhatsappNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LocalPrefKeys.fkUserID);
  }

  static Future<void> saveWhatsappNumber(String fkUserID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_LocalPrefKeys.fkUserID, fkUserID);
  }

  static Future<void> clearWhatsappNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_LocalPrefKeys.fkUserID);
  }

  static Future<void> saveFCMToken(String fcmToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_LocalPrefKeys.fcmToken, fcmToken);
  }

  static Future<String?> getFCMToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LocalPrefKeys.fcmToken);
  }

  static Future<void> clearFCMToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_LocalPrefKeys.fcmToken);
  }
}

class _LocalPrefKeys {
  static String token = "TOKEN_VALUE";
  static String userRole = "USER_ROLE";
  static String fullName = "FULL_NAME";
  static String image = "IMAGE";
  static String bearerToken = "Bearer $token";
  static String deviceKey = "DEVICE_KEY";
  static String fkUserID = "FK_USER_ID";
  static String whatsappNumber = "WHATSAPP_NUMBER";
  static String fcmToken = "FCM_TOKEN";
  static String passwordBySystem = "FALSE";
}
