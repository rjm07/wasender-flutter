class PerangkatSayaResponse {
  const PerangkatSayaResponse({
    required this.messageAction,
    required this.messageData,
    required this.messageDesc,
    required this.messageId,
    required this.statusCode,
  });

  final String messageAction;
  final dynamic messageData;
  final String messageDesc;
  final String messageId;
  final int statusCode;

  factory PerangkatSayaResponse.fromJson(Map<String, dynamic> json) {
    return PerangkatSayaResponse(
      messageAction: json["message_action"] as String,
      messageData: json["message_data"],
      messageDesc: json["message_desc"] as String,
      messageId: json["message_id"] as String,
      statusCode: json["status_code"] as int,
    );
  }
}
