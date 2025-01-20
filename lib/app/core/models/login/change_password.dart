class ChangePasswordResponse {
  const ChangePasswordResponse({
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

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      messageAction: json["message_action"] as String,
      messageCode: json["message_code"] as int,
      messageData: json["message_data"],
      messageDesc: json["message_desc"] as String,
      messageId: json["message_id"] as String,
    );
  }
}

class ChangePasswordData {
  const ChangePasswordData({
    required this.message,
    required this.success,
  });

  final String message;
  final bool success;
  factory ChangePasswordData.fromJson(Map<String, dynamic> json) {
    return ChangePasswordData(
      message: json["message"] as String,
      success: json["success"] as bool,
    );
  }
}
