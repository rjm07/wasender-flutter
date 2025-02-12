class PesanConversationResponse {
  final String messageAction;
  final MessageData messageData;
  final String? messageDesc;
  final String? messageId;
  final int? statusCode;

  PesanConversationResponse({
    required this.messageAction,
    required this.messageData,
    required this.messageDesc,
    required this.messageId,
    required this.statusCode,
  });

  factory PesanConversationResponse.fromJson(Map<String, dynamic> json) {
    return PesanConversationResponse(
      messageAction: json["message_action"],
      messageData: MessageData.fromJson(json["message_data"]),
      messageDesc: json["message_desc"],
      messageId: json["message_id"],
      statusCode: json["status_code"],
    );
  }
}

class MessageData {
  final Data data;
  final String message;
  final bool? success;

  MessageData({required this.data, required this.message, required this.success});
  factory MessageData.fromJson(Map<String, dynamic> json) => MessageData(
        data: Data.fromJson(json['data']),
        message: json['message'] as String,
        success: json['success'] as bool?,
      );
}

class Data {
  final IDData id;
  final List<Conversation> conversation;
  final String? remoteJID;
  final String? roomChat;

  Data({
    required this.id,
    required this.conversation,
    required this.remoteJID,
    required this.roomChat,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: IDData.fromJson(json["_id"]),
      conversation: (json["conversation"] as List).map((item) {
        return Conversation.fromJson(item);
      }).toList(),
      remoteJID: json["remoteJID"] as String?,
      roomChat: json["roomChat"] as String?,
    );
  }
}

class IDData {
  final String remoteJid;
  final String roomChat;

  IDData({
    required this.remoteJid,
    required this.roomChat,
  });

  factory IDData.fromJson(Map<String, dynamic> json) {
    return IDData(
      remoteJid: json["remote_jid"],
      roomChat: json["room_chat"],
    );
  }
}

class Conversation {
  final bool? isBot;
  final String? id;
  final String? type;
  final String? chat;
  final bool? broadcast;
  final String? category;
  final String? notify;
  final bool? fromMe;
  final String? senderName;
  final String? senderNumber;
  final int? messageTimestamp;
  final String? messageTimestampStr;
  final Message? message;
  final String? receipt;
  final int? status;
  final String? pkey;
  final String? channel;
  final String? roomChat;
  final String? ticketId;
  final String? ticketNumber;
  final String? agentId;
  final String? agentName;
  final String? trigger;
  final String? messageId;

  Conversation({
    this.isBot,
    this.id,
    this.broadcast,
    this.type,
    this.chat,
    this.category,
    this.notify,
    this.fromMe,
    this.senderName,
    this.senderNumber,
    this.messageTimestamp,
    this.messageTimestampStr,
    this.message,
    this.receipt,
    this.status,
    this.pkey,
    this.channel,
    this.roomChat,
    this.ticketId,
    this.ticketNumber,
    this.agentId,
    this.agentName,
    this.trigger,
    this.messageId,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      isBot: json['is_bot'] as bool?,
      id: json['id'] as String?,
      type: json['type'] as String?,
      chat: json['chat'] as String?,
      broadcast: json['broadcast'] as bool?,
      category: json['category'] as String?,
      notify: json['notify'] as String?,
      fromMe: json['from_me'] as bool?,
      senderName: json['sender_name'] as String?,
      senderNumber: json['sender_number'] as String?,
      messageTimestamp: json['messageTimestamp'] as int?,
      messageTimestampStr: json['messageTimestamp_str'] as String?,
      message: Message.fromJson(json['message']),
      receipt: json['receipt'] as String?,
      status: json['status'] as int?,
      pkey: json['pkey'] as String?,
      channel: json['channel'] as String?,
      roomChat: json['room_chat'] as String?,
      ticketId: json['ticket_id'] as String?,
      ticketNumber: json['ticket_number'] as String?,
      agentId: json['agent_id'] as String?,
      agentName: json['agent_name'] as String?,
      trigger: json['trigger'] as String?,
      messageId: json['message_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'chat': chat,
        'category': category,
        'notify': notify,
        'from_me': fromMe,
        'sender_name': senderName,
        'sender_number': senderNumber,
        'messageTimestamp': messageTimestamp,
        'messageTimestamp_str': messageTimestampStr,
        'message': message?.toJson(),
        'receipt': receipt,
        'status': status,
        'pkey': pkey,
        'channel': channel,
        'room_chat': roomChat,
        'ticket_id': ticketId,
        'ticket_number': ticketNumber,
        'agent_id': agentId,
        'agent_name': agentName,
        'trigger': trigger,
        'message_id': messageId,
      };
}

class Message {
  final bool? mentionedJid;
  final dynamic quotedMessage;
  final dynamic stanzaId;
  final String? text;
  final String? name;
  final dynamic file;
  final dynamic thumb;
  final String? caption;

  Message({
    this.mentionedJid,
    this.quotedMessage,
    this.stanzaId,
    required this.text,
    this.name,
    this.file,
    this.thumb,
    this.caption,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      mentionedJid: json['mentionedJid'] as bool?,
      quotedMessage: json['quotedMessage'],
      stanzaId: json['stanzaId'],
      text: json['text'] as String?,
      name: json['name'] as String?,
      file: json['file'],
      thumb: json['thumb'],
      caption: json['caption'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'mentionedJid': mentionedJid,
        'quotedMessage': quotedMessage,
        'stanzaId': stanzaId,
        'text': text,
        'name': name,
        'file': file,
        'thumb': thumb,
        'caption': caption,
      };
}

// // To parse from JSON string:
// ConversationResponse conversationResponseFromJson(String str) => ConversationResponse.fromJson(json.decode(str));
//
// // To convert to JSON string:
// String conversationResponseToJson(ConversationResponse data) => json.encode(data.toJson());
