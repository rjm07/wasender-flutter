class DeviceInfoResponse {
  final String messageAction;
  final DeviceInfoDataData? messageData;
  final String messageDesc;
  final String messageId;
  final int statusCode;

  DeviceInfoResponse({
    required this.messageAction,
    required this.messageData,
    required this.messageDesc,
    required this.messageId,
    required this.statusCode,
  });

  factory DeviceInfoResponse.fromJson(Map<String, dynamic> json) {
    return DeviceInfoResponse(
      messageAction: json['message_action'] as String,
      messageData: json['message_data'] != null ? DeviceInfoDataData.fromJson(json['message_data']) : null,
      messageDesc: json['message_desc'] as String,
      messageId: json['message_id'] as String,
      statusCode: json['status_code'] as int,
    );
  }
}

class DeviceInfoDataData {
  final DeviceInfoDataResponse? data;
  final String message;
  final bool success;

  DeviceInfoDataData({
    required this.data,
    required this.message,
    required this.success,
  });

  factory DeviceInfoDataData.fromJson(Map<String, dynamic> json) {
    return DeviceInfoDataData(
      data: json['data'] != null ? DeviceInfoDataResponse.fromJson(json['data']) : null,
      message: json['message'] as String? ?? '',
      success: json['success'] as bool? ?? false,
    );
  }
}

class DeviceInfoDataResponse {
  final DeviceData? data;
  final String message;
  final String routingKey;
  final String sessionID;
  final String sessionInit;
  final bool success;

  DeviceInfoDataResponse({
    required this.data,
    required this.message,
    required this.routingKey,
    required this.sessionID,
    required this.sessionInit,
    required this.success,
  });

  factory DeviceInfoDataResponse.fromJson(Map<String, dynamic> json) {
    return DeviceInfoDataResponse(
      data: json['data'] != null ? DeviceData.fromJson(json['data']) : null,
      message: json['message'] as String? ?? '',
      routingKey: json['routingKey'] as String? ?? '',
      sessionID: json['session_id'] as String? ?? '',
      sessionInit: json['session_init'] as String? ?? '',
      success: json['success'] as bool? ?? false,
    );
  }
}

class DeviceData {
  final bool isOn;
  final String sessionId;
  final UserData? user;

  DeviceData({
    required this.isOn,
    required this.sessionId,
    required this.user,
  });

  factory DeviceData.fromJson(Map<String, dynamic> json) {
    return DeviceData(
      isOn: json['isOn'] as bool? ?? false,
      sessionId: json['sessionId'] as String? ?? '',
      user: json['user'] != null ? UserData.fromJson(json['user']) : null,
    );
  }
}

class UserData {
  UserData();

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData();
  }
}
