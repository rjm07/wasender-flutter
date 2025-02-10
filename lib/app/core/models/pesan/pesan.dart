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
      messageAction: json['message_action'],
      messageData: ChatBoxResponseData.fromJson(json['message_data']),
      messageDesc: json['message_desc'],
      messageId: json['message_id'],
      statusCode: json['status_code'],
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
      message: json['message'],
      success: json['success'],
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
      isBot: json['is_bot'],
      messages: Messages.fromJson(json['messages']),
      notify: json['notify'],
      remoteJid: json['remote_jid'],
      roomChat: json['room_chat'],
      status: json['status'],
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
  final String? inboxType;
  final bool? isBot;
  final MessageContent message;
  final String messageTimestamp;
  final dynamic messageTimestampStr;
  final String messageId;
  final String progress;
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
    this.inboxType,
    this.isBot,
    required this.message,
    required this.messageTimestamp,
    required this.messageTimestampStr,
    required this.messageId,
    required this.receipt,
    required this.progress,
    required String? senderName,
    required this.senderNumber,
    required this.sessionId,
    required this.status,
    required this.ticketId,
    required this.ticketNumber,
    required this.type,
  }) : senderName = senderName ?? senderNumber;

  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
      agentId: json['agent_id'],
      agentName: json['agent_name'],
      broadcast: json['broadcast'],
      category: json['category'],
      chat: json['chat'],
      fromMe: json['from_me'],
      greeting: json['greeting'],
      id: json['id'],
      inboxType: json['inbox_type'],
      isBot: json['is_bot'],
      message: MessageContent.fromJson(json['message']),
      messageTimestamp: json['messageTimestamp'],
      messageTimestampStr: json['messageTimestamp_str'],
      messageId: json['message_id'],
      progress: json['progress'],
      receipt: json['receipt'],
      senderName: json['sender_name'] ?? '',
      senderNumber: json['sender_number'],
      sessionId: json['session_id'],
      status: json['status'],
      ticketId: json['ticket_id'],
      ticketNumber: json['ticket_number'],
      type: json['type'],
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
      caption: json['caption'],
      file: json['file'],
      name: json['name'],
      thumb: json['thumb'],
      mentionedJid: json['mentionedJid'],
      quotedMessage: json['quotedMessage'],
      stanzaId: json['stanzaId'],
      text: json['text'],
    );
  }

  bool get hasQuotedMessage => quotedMessage is Map<String, dynamic>;

  Map<String, dynamic>? get quotedMessageAsMap {
    return hasQuotedMessage ? quotedMessage as Map<String, dynamic> : null;
  }

  bool get quotedMessageAsBool {
    return quotedMessage is bool ? quotedMessage as bool : false;
  }
}
