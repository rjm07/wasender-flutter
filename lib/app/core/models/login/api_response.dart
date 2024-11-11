class ApiResponse {
  const ApiResponse({
    required this.messageAction,
    required this.messageCode,
    required this.messageData,
    required this.messageDesc,
    required this.messageId,
    required this.statusCode,
  });

  final String messageAction;
  final int messageCode;
  final dynamic messageData;
  final String messageDesc;
  final String messageId;
  final int statusCode;

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      messageAction: json["message_action"] as String,
      messageCode: json["message_code"] as int,
      messageData: json["message_data"],
      messageDesc: json["message_desc"] as String,
      messageId: json["message_id"] as String,
      statusCode: json["status_code"] as int,
    );
  }
}
