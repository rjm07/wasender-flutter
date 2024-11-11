import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wasender/app/core/providers/token.dart';

import '../../utils/lang/strings.dart';
import '../models/login/api_response.dart';
import '../models/login/user.dart';
import 'preferences.dart';

class Auth extends ChangeNotifier {
  Future<String?>? tokenFuture;

  void updateBrandIdFuture() {
    tokenFuture = LocalPrefs.getToken();
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    final String sequence = password + username;
    final ({int requestId, String token}) generated = TokenGenerator.generate(sequence);
    debugPrint("Generated Token: $generated");

    final Uri loginUri = Uri.parse("${API.baseUrl}${API.loginUrl}");
    debugPrint("Login URI: $loginUri");

    var request = http.MultipartRequest('POST', loginUri)
      ..fields['username'] = username
      ..fields['password'] = password
      ..headers.addAll({
        "RequestId": generated.requestId.toString(),
        "token": generated.token,
      });

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      debugPrint("Response: $responseBody");

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(responseBody) as Map<String, dynamic>;
        final ApiResponse loginResponse = ApiResponse.fromJson(json);

        if ((loginResponse.messageData as Map<String, dynamic>).isNotEmpty) {
          final User user = User.fromJson(loginResponse.messageData);
          await LocalPrefs.saveToken(user.accessToken);
          updateBrandIdFuture();
        } else {
          throw loginResponse.messageDesc;
        }
      } else {
        final String message = jsonDecode(responseBody)["message_desc"] as String;
        throw message;
      }
    } catch (error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw error.toString();
    }
  }

  Future<void> logout() async {
    await LocalPrefs.clearToken();
    updateBrandIdFuture();
  }
}
