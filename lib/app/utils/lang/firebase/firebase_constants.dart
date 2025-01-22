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
