class SendMediaResponse {
  const SendMediaResponse({
    required this.messageAction,
    required this.messageData,
    required this.messageDesc,
    required this.messageId,
    required this.statusCode,
  });

  final String messageAction;
  final SendMediaMessageData messageData;
  final String messageDesc;
  final String messageId;
  final int statusCode;

  factory SendMediaResponse.fromJson(Map<String, dynamic> json) {
    return SendMediaResponse(
      messageAction: json["message_action"] as String,
      messageData: json["message_data"],
      messageDesc: json["message_desc"] as String,
      messageId: json["message_id"] as String,
      statusCode: json["status_code"] as int,
    );
  }
}

class SendMediaMessageData {
  final Message message;
  final dynamic metaData;
  final bool? success;

  SendMediaMessageData({
    required this.message,
    required this.metaData,
    required this.success,
  });

  factory SendMediaMessageData.fromJson(Map<String, dynamic> json) {
    return SendMediaMessageData(
      message: json['message'],
      metaData: json['metadata'],
      success: json['success'] as bool?,
    );
  }
}

class Message {
  final MessageImageContent imageMessage;

  Message({
    required this.imageMessage,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      imageMessage: json['imageMessage'],
    );
  }
}

class MessageImageContent {
  final String? directPath;
  final String? fileEncSha256;
  final String? fileLength;
  final String? sileSha256;
  final String? mediaKey;
  final String? mediaKeyTimeStamp;
  final String? mimeType;
  final String? url;

  MessageImageContent({
    required this.directPath,
    required this.fileEncSha256,
    required this.fileLength,
    required this.sileSha256,
    required this.mediaKey,
    required this.mediaKeyTimeStamp,
    required this.mimeType,
    required this.url,
  });

  factory MessageImageContent.fromJson(Map<String, dynamic> json) {
    return MessageImageContent(
      directPath: json['directPath'] as String?,
      fileEncSha256: json['fileEncSha256'] as String?,
      fileLength: json['fileLength'] as String?,
      sileSha256: json['sileSha256'] as String?,
      mediaKey: json['mediaKey'] as String?,
      mediaKeyTimeStamp: json['mediaKeyTimeStamp'] as String?,
      mimeType: json['mimeType'] as String?,
      url: json['url'] as String?,
    );
  }
}
