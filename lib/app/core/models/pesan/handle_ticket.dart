class HandleTicketResponse {
  const HandleTicketResponse({
    required this.messageAction,
    required this.messageData,
    required this.messageDesc,
    required this.messageId,
  });

  final String messageAction;
  final HandleTicketMessageData messageData;
  final String messageDesc;
  final String messageId;

  factory HandleTicketResponse.fromJson(Map<String, dynamic> json) {
    return HandleTicketResponse(
      messageAction: json["message_action"] as String,
      messageData: json["message_data"],
      messageDesc: json["message_desc"] as String,
      messageId: json["message_id"] as String,
    );
  }
}

class HandleTicketMessageData {
  final String? customerWhatsapp;
  final String? message;
  final String? notification;
  final String roomChat;
  final bool? success;
  final List<String> ticketNumber;

  HandleTicketMessageData({
    this.customerWhatsapp,
    required this.message,
    this.notification,
    required this.roomChat,
    required this.success,
    required this.ticketNumber,
  });

  factory HandleTicketMessageData.fromJson(Map<String, dynamic> json) {
    return HandleTicketMessageData(
      customerWhatsapp: json['customer_whatsapp'] as String?,
      message: json['message'] as String?,
      notification: json['notification'] as String?,
      roomChat: json['room_chat'] as String,
      success: json['success'] as bool?,
      ticketNumber: (json['ticket_number'] as List).map((item) => item as String).toList(),
    );
  }
}
