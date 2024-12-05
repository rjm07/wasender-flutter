import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../utils/lang/strings.dart';
import 'package:http/http.dart' as http;

import '../../models/pesan/pesan.dart';
import '../../models/pesan/pesan_conversation.dart';
import '../../models/pesan/chat/pesan_send_chat.dart';

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
    String token,
    String deviceKey, {
    bool isPagination = false,
    required Function(String) showErrorSnackbar, // Error callback
  }) async {
    if (!isPagination) {
      resetPage();
    }
    final chatBoxDataDetail = await getChatBoxList(
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

    final Uri uri = Uri.parse("${API.baseUrl}/api/v1/message/$deviceKey/inbox");

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
          throw Exception(chatBoxResponse.messageDesc);
        }
      } else {
        throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw Exception(error.toString());
    }
  }

  Future<List<Conversation>> getChatBoxConversation(
    String token,
    String deviceKey,
    String roomChat,
  ) async {
    final Uri uri = Uri.parse("${API.baseUrl}/api/v1/message/$deviceKey/conversation/$roomChat");

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

  Future<SendMessageData> sendMessage(
    String token,
    String deviceKey,
    String roomChat,
    String sender,
    String receiver,
    String message,
  ) async {
    final Uri uri = Uri.parse("${API.baseUrl}/api/v1/chat/text/$deviceKey");

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
        "Authorization": "Bearer $token",
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
}
