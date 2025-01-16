class SendMessageResponse {
  const SendMessageResponse({
    required this.messageAction,
    required this.messageData,
    required this.messageDesc,
    required this.messageId,
    required this.statusCode,
  });

  final String messageAction;
  final SendMessageData messageData;
  final String messageDesc;
  final String messageId;
  final int statusCode;

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) {
    return SendMessageResponse(
      messageAction: json["message_action"] as String,
      messageData: json["message_data"],
      messageDesc: json["message_desc"] as String,
      messageId: json["message_id"] as String,
      statusCode: json["status_code"] as int,
    );
  }
}

class SendMessageData {
  final String? message;
  final dynamic metaData;
  final String? routingKey;
  final bool? success;

  SendMessageData({
    required this.message,
    required this.metaData,
    required this.routingKey,
    required this.success,
  });

  factory SendMessageData.fromJson(Map<String, dynamic> json) {
    return SendMessageData(
      message: json['message'] as String?,
      metaData: json['metadata'],
      routingKey: json['routingKey'] as String?,
      success: json['success'] as bool?,
    );
  }
}
