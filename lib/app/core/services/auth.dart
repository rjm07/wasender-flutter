import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:wasender/app/core/providers/token.dart';

import '../../utils/lang/strings.dart';
import '../models/login/api_response.dart';
import '../models/login/logout.dart';
import '../models/login/user.dart';
import 'preferences.dart';

class Auth extends ChangeNotifier {
  Future<String?>? tokenFuture;

  void updateBrandIdFuture() {
    tokenFuture = LocalPrefs.getToken();
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    // final String sequence = password + username;
    //final ({int requestId, String token}) generated = TokenGenerator.generate(sequence);
    // debugPrint("Generated Token: $generated");

    final Uri loginUri = Uri.parse("${API.baseUrl}${API.loginUrl}");
    debugPrint("Login URI: $loginUri");

    var request = http.MultipartRequest('POST', loginUri)
      ..fields['username'] = username
      ..fields['password'] = password
      ..headers.addAll({
        // "RequestId": generated.requestId.toString(),
        // "token": generated.token,
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
          await LocalPrefs.saveFKUserID(user.fkUserID);
          await LocalPrefs.saveUserRole(user.role);
          await LocalPrefs.saveFullName(user.fullName);
          await LocalPrefs.saveImage(user.avatar);
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
    final String? fkUserID = await LocalPrefs.getFKUserID();
    final Uri uri = Uri.parse("${API.baseUrl}${API.logoutUrl}");

    debugPrint("Calling $uri");

    // Constructing the JSON payload
    final Map<String, dynamic> payload = {
      "fk_user_id": fkUserID,
    };

    debugPrint('fkUserID: $fkUserID');

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(payload),
    );

    debugPrint(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final LogoutResponse logoutResponse = LogoutResponse.fromJson(json);
      final Map<String, dynamic> messageData = logoutResponse.messageData as Map<String, dynamic>;
      final bool success = messageData['success'] as bool;

      if (success) {
        await LocalPrefs.clearToken();
        await LocalPrefs.clearFKUserID();
        await LocalPrefs.clearWhatsappNumber();
        await LocalPrefs.clearUserRole();
        await LocalPrefs.clearFullName();
        await LocalPrefs.clearImage();
        updateBrandIdFuture();
      } else {
        throw logoutResponse.messageDesc;
      }
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }
}
// Future<void> logout2() async {
//   await LocalPrefs.clearToken();
//   await LocalPrefs.clearFKUserID();
//   await LocalPrefs.clearWhatsappNumber();
//   await LocalPrefs.clearUserRole();
//   await LocalPrefs.clearFullName();
//   await LocalPrefs.clearImage();
//   updateBrandIdFuture();
// }
