class API {
  // static String socomKey = const String.fromEnvironment("socomKey");
  // static String socomSec = const String.fromEnvironment("socomSec");
  // static String hashKey = const String.fromEnvironment("hashKey");

  static String baseUrl = const String.fromEnvironment("baseUrl");
  static String loginUrl = "/v1/oauth";
  static String logoutUrl = "/v1/logout";

  //DASHBOARD APIS
  static String dashboardUrl = "/v2";

  //SOCKET IO
  static String socketUrl = const String.fromEnvironment("socketURL");
}

class FirebaseConstants {
  static String projectId = const String.fromEnvironment("FIREBASE_PROJECT_ID");
  static String messagingSenderId = const String.fromEnvironment("FIREBASE_MESSAGING_SENDER_ID");
  static String storageBucket = const String.fromEnvironment("FIREBASE_STORAGE_BUCKET");
  static String androidApiKey = const String.fromEnvironment("FIREBASE_ANDROID_API_KEY");
  static String androidAppId = const String.fromEnvironment("FIREBASE_ANDROID_APP_ID");
  static String iosApiKey = const String.fromEnvironment("FIREBASE_IOS_API_KEY");
  static String iosAppId = const String.fromEnvironment("FIREBASE_IOS_APP_ID");
  static String iosBundleId = const String.fromEnvironment("FIREBASE_IOS_BUNDLE_ID");
}
