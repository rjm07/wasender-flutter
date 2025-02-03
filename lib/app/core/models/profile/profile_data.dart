class ProfileDataResponse {
  const ProfileDataResponse({
    required this.messageAction,
    required this.messageCode,
    required this.messageData,
    required this.messageDesc,
    required this.messageId,
  });

  final String? messageAction;
  final int? messageCode;
  final ProfileData? messageData;
  final String? messageDesc;
  final String? messageId;

  factory ProfileDataResponse.fromJson(Map<String, dynamic> json) {
    return ProfileDataResponse(
      messageAction: json["message_action"] as String?,
      messageCode: json["message_code"] as int?,
      messageData: ProfileData.fromJson(json["message_data"] as Map<String, dynamic>),
      messageDesc: json["message_desc"] as String?,
      messageId: json["message_id"] as String?,
    );
  }
}

class ProfileData {
  const ProfileData({
    required this.avatar,
    required this.clientId,
    required this.deviceAllowed,
    required this.email,
    required this.fkUserId,
    required this.fullName,
    required this.inactive,
    required this.loginLog,
    required this.passwordBySystem,
    required this.role,
    required this.twoAuthenticationAuth,
    required this.userActivation,
    required this.verification,
  });

  final String? avatar;
  final String? clientId;
  final List<dynamic>? deviceAllowed;
  final String? email;
  final String? fkUserId;
  final String? fullName;
  final String? inactive;
  final List<LoginLogData>? loginLog;
  final String? passwordBySystem;
  final String? role;
  final bool? twoAuthenticationAuth;
  final bool? userActivation;
  final VerificationData? verification;

  factory ProfileData.fromJson(Map<String, dynamic> json) {

    var list = json['login_log'] as List;
    List<LoginLogData> imagesList = list.map((i) => LoginLogData.fromJson(i)).toList();

    return ProfileData(
      avatar: json["avatar"] as String?,
      clientId: json["client_id"] as String?,
      deviceAllowed: json["device_allowed"] as List<dynamic>?,
      email: json["email"] as String?,
      fkUserId: json["fk_user_id"] as String?,
      fullName: json["fullname"] as String?,
      inactive: json["inactive"] as String?,
      loginLog: imagesList,
      passwordBySystem: json["password_by_system"] as String?,
      role: json["role"] as String?,
      twoAuthenticationAuth: json["two_authentication_auth"] as bool?,
      userActivation: json["user_activation"] as bool?,
      verification: VerificationData.fromJson(json["verification"] as Map<String, dynamic>),
    );
  }
}

class LoginLogData {
  const LoginLogData({
    required this.browser,
    required this.ipAddress,
    required this.timestamp,
    required this.timestampStr,
    required this.userAgent,
  });

  final String? browser;
  final String? ipAddress;
  final int? timestamp;
  final String? timestampStr;
  final String? userAgent;

  factory LoginLogData.fromJson(Map<String, dynamic> json) {
    return LoginLogData(
      browser: json["browser"] as String?,
      ipAddress: json["ip_address"] as String?,
      timestamp: json["timestamp"] as int?,
      timestampStr: json["timestamp_str"] as String?,
      userAgent: json["user_agent"] as String?,
    );
  }
}
class VerificationData {
  const VerificationData({
    required this.email,
    required this.whatsapp,
  });

  final bool? email;
  final bool? whatsapp;

  factory VerificationData.fromJson(Map<String, dynamic> json) {
    return VerificationData(
      email: json["email"] as bool?,
      whatsapp: json["whatsapp"] as bool?,
    );
  }
}