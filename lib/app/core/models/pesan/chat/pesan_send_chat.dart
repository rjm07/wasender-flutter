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

class Message {
  final Key key;
  final MessageContent message;
  final String? messageStamp;
  final String? status;

  Message({
    required this.key,
    required this.message,
    required this.messageStamp,
    required this.status,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      key: json['key'],
      message: json['message'],
      messageStamp: json['messageStamp'] as String?,
      status: json['status'] as String?,
    );
  }
}

class Key {
  final bool? fromMe;
  final String? id;
  final String? remoteJID;

  Key({
    required this.fromMe,
    required this.id,
    required this.remoteJID,
  });

  factory Key.fromJson(Map<String, dynamic> json) {
    return Key(
      fromMe: json['fromMe'] as bool?,
      id: json['id'] as String?,
      remoteJID: json['remoteJID'] as String?,
    );
  }
}

class MessageContent {
  final dynamic extendedTextMessage;
  MessageContent({
    required this.extendedTextMessage,
  });

  factory MessageContent.fromJson(Map<String, dynamic> json) {
    return MessageContent(
      extendedTextMessage: json['extendedTextMessage'],
    );
  }
}

class ExtendedTextMessage {
  final String? text;

  ExtendedTextMessage({
    required this.text,
  });

  factory ExtendedTextMessage.fromJson(Map<String, dynamic> json) {
    return ExtendedTextMessage(
      text: json['text'] as String?,
    );
  }
}
