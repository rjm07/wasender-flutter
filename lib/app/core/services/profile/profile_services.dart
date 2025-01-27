import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../utils/lang/api/api_strings.dart';
import '../../models/profile/profile_data.dart';
import '../preferences.dart';

class ProfileServices extends ChangeNotifier {
  int page = 1;
  int perPage = 10;
  bool isLoading = false;

  Future<ProfileDataResponse?> getProfileData(
      String token,
      ) async {
    final String? token = await LocalPrefs.getBearerToken();
    final Uri uri = Uri.parse("${API.baseUrl}${API.profileUrl}");
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
        final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;
        final ProfileDataResponse profileDataResponse = ProfileDataResponse.fromJson(json);

        return profileDataResponse;
      } else {
        final String message = jsonDecode(response.body)["message_desc"];

        throw Exception(message);
      }
    } catch (error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);

      throw Exception(error.toString());
    }
  }

}