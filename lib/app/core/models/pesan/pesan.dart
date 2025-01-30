class ChatBoxResponse {
  final String messageAction;
  final ChatBoxResponseData messageData;
  final String messageDesc;
  final String messageId;
  final int statusCode;

  ChatBoxResponse({
    required this.messageAction,
    required this.messageData,
    required this.messageDesc,
    required this.messageId,
    required this.statusCode,
  });

  factory ChatBoxResponse.fromJson(Map<String, dynamic> json) {
    return ChatBoxResponse(
      messageAction: json['message_action'] as String,
      messageData: ChatBoxResponseData.fromJson(json['message_data']),
      messageDesc: json['message_desc'] as String,
      messageId: json['message_id'] as String,
      statusCode: json['status_code'] as int,
    );
  }
}

class ChatBoxResponseData {
  final List<ChatBoxDataList> data;
  final String message;
  final bool success;

  ChatBoxResponseData({
    required this.data,
    required this.message,
    required this.success,
  });

  factory ChatBoxResponseData.fromJson(Map<String, dynamic> json) {
    return ChatBoxResponseData(
      data: (json['data'] as List).map((item) => ChatBoxDataList.fromJson(item)).toList(),
      message: json['message'] as String,
      success: json['success'] as bool,
    );
  }
}

class ChatBoxDataList {
  final bool isBot;
  final Messages messages;
  final String notify;
  final String remoteJid;
  final String roomChat;
  final String status;

  ChatBoxDataList({
    required this.isBot,
    required this.messages,
    required this.notify,
    required this.remoteJid,
    required this.roomChat,
    required this.status,
  });

  factory ChatBoxDataList.fromJson(Map<String, dynamic> json) {
    return ChatBoxDataList(
      isBot: json['is_bot'] as bool,
      messages: Messages.fromJson(json['messages']),
      notify: json['notify'] as String,
      remoteJid: json['remote_jid'] as String,
      roomChat: json['room_chat'] as String,
      status: json['status'] as String,
    );
  }
}

class Messages {
  final String? agentId;
  final String? agentName;
  final dynamic broadcast;
  final String category;
  final String chat;
  final bool fromMe;
  final bool greeting;
  final String id;
  final MessageContent message;
  final int messageTimestamp;
  final String messageTimestampStr;
  final String messageId;
  final String receipt;
  final String senderName;
  final String senderNumber;
  final String sessionId;
  final int status;
  final String? ticketId;
  final String? ticketNumber;
  final String type;

  Messages({
    this.agentId,
    this.agentName,
    required this.broadcast,
    required this.category,
    required this.chat,
    required this.fromMe,
    required this.greeting,
    required this.id,
    required this.message,
    required this.messageTimestamp,
    required this.messageTimestampStr,
    required this.messageId,
    required this.receipt,
    required this.senderName,
    required this.senderNumber,
    required this.sessionId,
    required this.status,
    required this.ticketId,
    required this.ticketNumber,
    required this.type,
  });

  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
      agentId: json['agent_id'] as String?,
      agentName: json['agent_name'] as String?,
      broadcast: json['broadcast'],
      category: json['category'] as String,
      chat: json['chat'] as String,
      fromMe: json['from_me'] as bool,
      greeting: json['greeting'] as bool,
      id: json['id'] as String,
      message: MessageContent.fromJson(json['message']),
      messageTimestamp: json['messageTimestamp'] as int,
      messageTimestampStr: json['messageTimestamp_str'] as String,
      messageId: json['message_id'] as String,
      receipt: json['receipt'] as String,
      senderName: json['sender_name'] as String,
      senderNumber: json['sender_number'] as String,
      sessionId: json['session_id'] as String,
      status: json['status'] as int,
      ticketId: json['ticket_id'] as String?,
      ticketNumber: json['ticket_number'] as String?,
      type: json['type'] as String,
    );
  }
}

class MessageContent {
  final String? caption;
  final String? file;
  final String? name;
  final String? thumb;
  final bool? mentionedJid;
  final dynamic quotedMessage;
  final dynamic stanzaId;
  final String? text;

  MessageContent({
    required this.caption,
    required this.file,
    required this.name,
    required this.thumb,
    required this.mentionedJid,
    required this.quotedMessage,
    required this.stanzaId,
    required this.text,
  });

  factory MessageContent.fromJson(Map<String, dynamic> json) {
    return MessageContent(
      caption: json['caption'] as String?,
      file: json['file'] as String?,
      name: json['name'] as String?,
      thumb: json['thumb'] as String?,
      mentionedJid: json['mentionedJid'] as bool?,
      quotedMessage: json['quotedMessage'],
      stanzaId: json['stanzaId'],
      text: json['text'] as String?,
    );
  }
}
