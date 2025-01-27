class API {
  //BASE APIS
  static String baseUrl = const String.fromEnvironment("baseUrl");
  static String socketUrl = const String.fromEnvironment("socketURL"); //SOCKET IO
  // static String whatUpKey = const String.fromEnvironment("whatUpKey");
  // static String whatUpSec = const String.fromEnvironment("whatUpSec");
  // static String hashKey = const String.fromEnvironment("hashKey");

  //VERSION APIS
  static String versionUrl = "/v1";
  static String dashboardUrl = "/v2";

  //PASSWORD APIS
  static String passwordUrl = "$versionUrl/password";

  //LOGIN APIS
  static String loginUrl = "/v1/oauth";
  static String logoutUrl = "/v1/logout";

  // DEVICES APIS
  static String deviceUrl = "$versionUrl/device/";
  static String deviceListUrl = "$versionUrl/device/lists";

  // MESSAGE APIS
  static String messageUrl = "$versionUrl/message/";
  static String chatMediaUrl = "$versionUrl/chat/media/";
  static String chatTextUrl = "$versionUrl/chat/text/";
  static String ticketAssignUrl = "$versionUrl/ticket/assign";

  //FIREBASE APIS
  static String fcmUrl = "$versionUrl/device/token";

  //PROFILE APIS
  static String profileUrl = "$versionUrl/profile";
}
