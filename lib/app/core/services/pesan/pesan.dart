import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../utils/lang/strings.dart';
import 'package:http/http.dart' as http;

import '../../models/pesan/pesan.dart';

class PesanServices extends ChangeNotifier {
  int page = 1;
  int perPage = 12;
  bool isLoading = false;
  Future<List<ChatBoxDataList>>? chatBoxDataDetails;

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

  Future<void> updateDeviceListFuture(
    String token,
    String deviceKey, {
    bool isPagination = false,
    required Function(String) showErrorSnackbar, // Error callback
  }) async {
    if (!isPagination) {
      resetPage();
    }
    chatBoxDataDetails = getChatBoxList(
      token,
      deviceKey,
      page,
      perPage,
    );

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

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final ChatBoxResponse chatBoxResponse = ChatBoxResponse.fromJson(json);

        if (chatBoxResponse.messageData.data.isNotEmpty) {
          return chatBoxResponse.messageData.data;
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
}
