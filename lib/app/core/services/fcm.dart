import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:wasender/app/core/services/preferences.dart';
import 'package:http/http.dart' as http;

import '../../utils/lang/strings.dart';
import '../models/dashboard/dashboard_response.dart';

class FCMServices extends ChangeNotifier {
  bool isLoading = false;

  void showSpinner(bool value) {
    isLoading = value;
    notifyListeners();
  }

  //MARK: Send FCM/ Device
  Future<SendFCMTokenResponse> sendFCMToken() async {
    final String? tokenBearer = await LocalPrefs.getBearerToken();
    final String? fkUserID = await LocalPrefs.getFKUserID();
    final String? fcmToken = await LocalPrefs.getFCMToken();
    final Uri uri = Uri.parse("${API.baseUrl}/v1/user/device-token");

    debugPrint("Calling $uri");

    // Constructing the JSON payload
    final Map<String, dynamic> payload = {
      "fk_user_id": fkUserID,
      "device_token": fcmToken,
    };

    debugPrint('fk user id: $fkUserID');
    debugPrint('device token: $fcmToken');

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
      final DashboardResponse dashboardResponse = DashboardResponse.fromJson(json);
      final Map<String, dynamic> messageData = dashboardResponse.messageData as Map<String, dynamic>;

      if (messageData.isNotEmpty) {
        final SendFCMTokenResponse data = SendFCMTokenResponse.fromJson(dashboardResponse.messageData);
        return data;
      } else {
        return throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }
}
