class LogoutResponse {
  const LogoutResponse({
    required this.messageAction,
    required this.messageCode,
    required this.messageData,
    required this.messageDesc,
    required this.messageId,
  });

  final String messageAction;
  final int messageCode;
  final dynamic messageData;
  final String messageDesc;
  final String messageId;

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      messageAction: json["message_action"] as String,
      messageCode: json["message_code"] as int,
      messageData: json["message_data"],
      messageDesc: json["message_desc"] as String,
      messageId: json["message_id"] as String,
    );
  }
}

class LogoutResponseData {
  const LogoutResponseData({
    required this.message,
    required this.success,
  });

  final String message;
  final bool success;
  factory LogoutResponseData.fromJson(Map<String, dynamic> json) {
    return LogoutResponseData(
      message: json["message"] as String,
      success: json["success"] as bool,
    );
  }
}
