import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wasender/app/core/models/login/change_password.dart';

import '../../ui/shared/widgets/wrappers/auth_wrapper.dart';
import '../../utils/lang/api/api_strings.dart';
import '../models/login/api_response.dart';
import '../models/login/logout.dart';
import '../models/login/user.dart';
import 'navigation/navigation.dart';
import 'preferences.dart';

class Auth extends ChangeNotifier {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<String?>? tokenFuture;

  void updateBrandIdFuture() {
    tokenFuture = LocalPrefs.getToken();
    notifyListeners();
  }

  void clearTokenFuture() async {
    LocalPrefs.clearToken();
    notifyListeners();
  }

  Future<ApiResponse?> login(String username, String password) async {
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
        //final User user = User.fromJson(loginResponse.messageData);
        final Map<String, dynamic> messageData = loginResponse.messageData as Map<String, dynamic>;

        if (messageData.isNotEmpty) {
          final User user = User.fromJson(loginResponse.messageData);
          await LocalPrefs.saveToken(user.accessToken);
          await LocalPrefs.saveFKUserID(user.fkUserID);
          await LocalPrefs.saveUserRole(user.role);
          await LocalPrefs.saveFullName(user.fullName);
          await LocalPrefs.saveImage(user.avatar);
          await LocalPrefs.savePassBySystem(user.passwordBySystem);
          //
          if (kDebugMode) {
            print('Login Successful: ${loginResponse.messageDesc}');
          }
          return loginResponse;
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

  Future<Map<String, String?>> getTokenAndPassBySystem() async {
    final String? brandId = await LocalPrefs.getToken();
    final String? passBySystem = await LocalPrefs.getPassBySystem(); // Assuming this method exists
    return {
      'brandId': brandId,
      'passBySystem': passBySystem,
    };
  }

  Future<void> logout() async {
    final String? fkUserID = await LocalPrefs.getFKUserID();
    final String? tokenBearer = await LocalPrefs.getBearerToken();

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
        "Authorization": "Bearer $tokenBearer",
      },
      body: jsonEncode(payload),
    );

    debugPrint(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final LogoutResponse logoutResponse = LogoutResponse.fromJson(json);
      final Map<String, dynamic> messageData = logoutResponse.messageData as Map<String, dynamic>;

      if (messageData['success'] == true) {
        await LocalPrefs.clearToken();
        tokenFuture = Future.value(null);
        await LocalPrefs.clearFKUserID();
        await LocalPrefs.clearUserRole();
        await LocalPrefs.clearFullName();
        await LocalPrefs.clearImage();
        await LocalPrefs.clearPassBySystem();
        await LocalPrefs.clearDeviceKey();
        await LocalPrefs.clearSelectedPKey();
        await LocalPrefs.clearFullName();

        if (kDebugMode) {
          print('Logout Successful');
          print('Token: ${await LocalPrefs.getToken()}');
          print('FKUserID: ${await LocalPrefs.getFKUserID()}');
          print('UserRole: ${await LocalPrefs.getUserRole()}');
          print('FullName: ${await LocalPrefs.getFullName()}');
          print('Image: ${await LocalPrefs.getImage()}');
          print('PassBySystem: ${await LocalPrefs.getPassBySystem()}');
          print('DeviceKey: ${await LocalPrefs.getDeviceKey()}');
        }

        clearTokenFuture();
        notifyListeners();
        NavService.popUntilAndPush(popUntilRoute: '/auth', pushScreen: AuthWrapper());
      } else {
        throw logoutResponse.messageDesc;
      }
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }

  Future<ChangePasswordResponse?> changePassword(String password, String passwordConfirmation) async {
    final String? bearerToken = await LocalPrefs.getBearerToken();
    final Uri uri = Uri.parse("${API.baseUrl}${API.passwordUrl}");

    debugPrint("Calling $uri");

    // Constructing the JSON payload
    final Map<String, dynamic> payload = {"password": password, "password_confirmation": passwordConfirmation};

    debugPrint('password: $password');
    debugPrint('confirm password: $passwordConfirmation');

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $bearerToken",
      },
      body: jsonEncode(payload),
    );

    debugPrint(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final ChangePasswordResponse changePasswordResponse = ChangePasswordResponse.fromJson(json);
      final Map<String, dynamic> messageData = changePasswordResponse.messageData as Map<String, dynamic>;

      final bool success = messageData['success'] as bool;

      if (success) {
        if (kDebugMode) {
          print('Password changed successfully!');
        }
        return changePasswordResponse;
      } else {
        if (kDebugMode) {
          print('Password has error!');
        }
        throw Exception(changePasswordResponse.messageDesc);
      }
    } else {
      final String message = jsonDecode(response.body)["message_data"]["message"] as String;
      throw Exception(message);
    }
  }

  Future<void> clearAllData() async {
    await LocalPrefs.clearToken();
    await LocalPrefs.clearFKUserID();
    await LocalPrefs.clearWhatsappNumber();
    await LocalPrefs.clearUserRole();
    await LocalPrefs.clearFullName();
    await LocalPrefs.clearImage();
    await LocalPrefs.clearPassBySystem();
    await LocalPrefs.clearFCMToken();
    await LocalPrefs.clearDeviceKey();
    await LocalPrefs.clearFullName();
    updateBrandIdFuture();
  }
}
