import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../../utils/lang/strings.dart';
import 'package:http/http.dart' as http;

import '../../models/pesan/handle_ticket.dart';
import '../../models/pesan/pesan.dart';
import '../../models/pesan/pesan_conversation.dart';
import '../../models/pesan/chat/pesan_send_chat.dart';
import '../preferences.dart';

class PesanServices extends ChangeNotifier {
  int page = 1;
  int perPage = 12;
  bool isLoading = false;
  List<ChatBoxDataList> chatBoxDataDetails = [];

  void incrementPage() {
    page++;
    notifyListeners();
  }

  void resetPage() {
    page = 1;
    notifyListeners();
  }

  void showSpinner(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> updateChatBoxListFuture(
    String status,
    String token,
    String deviceKey, {
    bool isPagination = false,
    required Function(String) showErrorSnackbar, // Error callback
  }) async {
    if (!isPagination) {
      resetPage();
    }
    if (status == 'active') {
      final chatBoxDataDetail = await getActiveChatBoxList(
        token,
        deviceKey,
        page,
        perPage,
      );
      if (isPagination) {
        chatBoxDataDetails.addAll(chatBoxDataDetail);
      } else {
        chatBoxDataDetails = chatBoxDataDetail;
      }
    } else if (status == 'closed') {
      final chatBoxDataDetail = await getClosedChatBoxList(
        token,
        deviceKey,
        page,
        perPage,
      );
      if (isPagination) {
        chatBoxDataDetails.addAll(chatBoxDataDetail);
      } else {
        chatBoxDataDetails = chatBoxDataDetail;
      }
    } else if (status == 'open') {
      final chatBoxDataDetail = await getOpenChatBoxList(
        token,
        deviceKey,
        page,
        perPage,
      );
      if (isPagination) {
        chatBoxDataDetails.addAll(chatBoxDataDetail);
      } else {
        chatBoxDataDetails = chatBoxDataDetail;
      }
    }
    notifyListeners();
  }

  Future<List<ChatBoxDataList>> getChatBoxList(
    String token,
    String deviceKey,
    int page,
    int perPage,
  ) async {
    final queryParams = {
      'page': page,
      'per_page': perPage,
    };
    final keys = queryParams.keys.toList()..sort();
    String sequence = keys.map((key) => queryParams[key]!).join();
    if (sequence.isEmpty) {
      sequence = "NA";
    }

    final Uri uri = Uri.parse("${API.baseUrl}/v1/message/$deviceKey/inbox");

    debugPrint("Calling $uri");
    try {
      final response = await http.get(
        uri,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      debugPrint(response.body);
      showSpinner(false);
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final ChatBoxResponse chatBoxResponse = ChatBoxResponse.fromJson(json);

        if (chatBoxResponse.messageData.data.isNotEmpty) {
          List<ChatBoxDataList> chatBoxList = chatBoxResponse.messageData.data;
          return chatBoxList;
        } else {
          debugPrint("ChatBox list is empty.");
          chatBoxDataDetails = chatBoxDataDetails;
          return [];
        }
      } else {
        throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw Exception(error.toString());
    }
  }

  //MARK: Get Active Conversation
  Future<List<ChatBoxDataList>> getActiveChatBoxList(
    String token,
    String deviceKey,
    int page,
    int perPage,
  ) async {
    final queryParams = {
      'page': page,
      'per_page': perPage,
    };
    final keys = queryParams.keys.toList()..sort();
    String sequence = keys.map((key) => queryParams[key]!).join();
    if (sequence.isEmpty) {
      sequence = "NA";
    }

    final Uri uri = Uri.parse('${API.baseUrl}/v1/message/$deviceKey/inbox?status=active');

    debugPrint("Calling $uri");
    try {
      final response = await http.get(
        uri,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      debugPrint(response.body);
      showSpinner(false);
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final ChatBoxResponse chatBoxResponse = ChatBoxResponse.fromJson(json);

        if (chatBoxResponse.messageData.data.isNotEmpty) {
          List<ChatBoxDataList> chatBoxList = chatBoxResponse.messageData.data;
          return chatBoxList;
        } else {
          debugPrint("ChatBox list is empty.");
          chatBoxDataDetails = chatBoxDataDetails;
          return [];
        }
      } else {
        throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw Exception(error.toString());
    }
  }

//MARK: Get Closed Conversation
  Future<List<ChatBoxDataList>> getClosedChatBoxList(
    String token,
    String deviceKey,
    int page,
    int perPage,
  ) async {
    final queryParams = {
      'page': page,
      'per_page': perPage,
    };
    final keys = queryParams.keys.toList()..sort();
    String sequence = keys.map((key) => queryParams[key]!).join();
    if (sequence.isEmpty) {
      sequence = "NA";
    }

    final Uri uri = Uri.parse('${API.baseUrl}/v1/message/$deviceKey/inbox?status=close');

    debugPrint("Calling $uri");
    try {
      final response = await http.get(
        uri,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      debugPrint(response.body);
      showSpinner(false);
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final ChatBoxResponse chatBoxResponse = ChatBoxResponse.fromJson(json);

        if (chatBoxResponse.messageData.data.isNotEmpty) {
          List<ChatBoxDataList> chatBoxList = chatBoxResponse.messageData.data;
          return chatBoxList;
        } else {
          debugPrint("ChatBox list is empty.");
          chatBoxDataDetails = chatBoxDataDetails;
          return [];
        }
      } else {
        throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw Exception(error.toString());
    }
  }

//MARK: Get Open Conversation
  Future<List<ChatBoxDataList>> getOpenChatBoxList(
    String token,
    String deviceKey,
    int page,
    int perPage,
  ) async {
    final queryParams = {
      'page': page,
      'per_page': perPage,
    };
    final keys = queryParams.keys.toList()..sort();
    String sequence = keys.map((key) => queryParams[key]!).join();
    if (sequence.isEmpty) {
      sequence = "NA";
    }

    final Uri uri = Uri.parse('${API.baseUrl}/v1/message/$deviceKey/inbox?status=open');

    debugPrint("Calling $uri");
    try {
      final response = await http.get(
        uri,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      debugPrint(response.body);
      showSpinner(false);
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final ChatBoxResponse chatBoxResponse = ChatBoxResponse.fromJson(json);

        if (chatBoxResponse.messageData.data.isNotEmpty) {
          List<ChatBoxDataList> chatBoxList = chatBoxResponse.messageData.data;
          return chatBoxList;
        } else {
          debugPrint("ChatBox list is empty.");
          chatBoxDataDetails = chatBoxDataDetails;
          return [];
        }
      } else {
        throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw Exception(error.toString());
    }
  }

  //MARK: Get Conversation

  Future<List<Conversation>> getChatBoxConversation(
    String token,
    String deviceKey,
    String roomChat,
  ) async {
    final Uri uri = Uri.parse("${API.baseUrl}/v1/message/$deviceKey/conversation/$roomChat");

    debugPrint("Calling $uri");
    try {
      final response = await http.get(
        uri,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      debugPrint(response.body);
      showSpinner(false);
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final PesanConversationResponse pesanConversationResponse = PesanConversationResponse.fromJson(json);

        if (pesanConversationResponse.messageData.data.conversation.isNotEmpty) {
          List<Conversation> conversation = pesanConversationResponse.messageData.data.conversation;
          return conversation;
        } else {
          throw Exception("No conversation found");
        }
      } else {
        throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw Exception('Error: ${error.toString()}');
    }
  }

//MARK: Send Message
  Future<SendMessageData> sendMessage(
    String roomChat,
    String sender,
    String receiver,
    String message,
  ) async {
    final String? tokenBearer = await LocalPrefs.getBearerToken();
    final String? deviceKey = await LocalPrefs.getDeviceKey();
    final Uri uri = Uri.parse("${API.baseUrl}/v1/chat/text/$deviceKey");

    debugPrint("Calling $uri");

    // Constructing the JSON payload
    final Map<String, dynamic> payload = {
      "room_chat": roomChat,
      "sender": sender,
      "receiver": receiver,
      "message": message,
    };

    debugPrint('room chat: $roomChat');
    debugPrint('sender: $sender');
    debugPrint('receiver: $receiver');
    debugPrint('message: $message');

    final response = await http.post(
      uri,
      headers: {
        "Authorization": "Bearer $tokenBearer",
        "Content-Type": "application/json",
      },
      body: jsonEncode(payload),
    );

    debugPrint(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);

      // Parsing the response into the SendMessageResponse model
      return SendMessageData.fromJson(json);
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }

  Future<SendMessageData> sendMedia(
      String type, String roomChat, String sender, String receiver, String caption, File file) async {
    final String? tokenBearer = await LocalPrefs.getBearerToken();
    final String? deviceKey = await LocalPrefs.getDeviceKey();
    final Uri uri = Uri.parse("${API.baseUrl}/v1/chat/media/$deviceKey");

    debugPrint("Calling $uri");

    // Creating multipart request
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $tokenBearer'
      ..fields['room_chat'] = roomChat
      ..fields['sender'] = sender
      ..fields['receiver'] = receiver
      ..fields['caption'] = caption
      ..fields['type'] = type;

    // Adding file to the request
    request.files.add(await http.MultipartFile.fromPath('images', file.path)); // Use file.path here

    debugPrint('room chat: $roomChat');
    debugPrint('sender: $sender');
    debugPrint('receiver: $receiver');
    debugPrint('caption: $caption');
    debugPrint('type: $type');
    debugPrint('file path: ${file.path}');

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        // Parsing the response into the SendMessageResponse model
        return SendMessageData.fromJson(json);
      } else {
        throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error occurred while sending media: $e');
      throw Exception('Failed to send media.');
    }
  }

//MARK: Handle Ticket
  Future<HandleTicketMessageData> assignTicket(
    String roomChat,
    String customerWhatsapp,
  ) async {
    final Uri uri = Uri.parse("${API.baseUrl}/v1/assign/ticket");

    debugPrint("Calling $uri");

    final String? tokenBearer = await LocalPrefs.getBearerToken();
    final String? deviceKey = await LocalPrefs.getDeviceKey();

    // Constructing the JSON payload
    final Map<String, dynamic> payload = {
      "device_pkey": deviceKey,
      "room_chat": roomChat,
      "customer_whatsapp": customerWhatsapp,
    };

    debugPrint('room chat: $roomChat');
    debugPrint('deviceKey: $deviceKey');
    debugPrint('customer whatsapp: $customerWhatsapp');

    final response = await http.post(
      uri,
      headers: {
        "Authorization": "Bearer $tokenBearer",
        "Content-Type": "application/json",
      },
      body: jsonEncode(payload),
    );

    debugPrint(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);

      // Parsing the response into the SendMessageResponse model
      return HandleTicketMessageData.fromJson(json);
    } else {
      String errorMessage = 'Unknown error';
      final Map<String, dynamic> json = jsonDecode(response.body);
      errorMessage = json['message_data']['message'] ?? json['error'] ?? errorMessage;
      throw Exception(errorMessage);
    }
  }
}
