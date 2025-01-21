import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../utils/lang/strings.dart';
import '../../models/perangkat_saya/api_response.dart';
import '../../models/perangkat_saya/perangkat_saya.dart';
import 'package:http/http.dart' as http;

import '../../models/perangkat_saya/perangkat_saya_detail.dart';
import '../preferences.dart';

class PerangkatSayaServices extends ChangeNotifier {
  int page = 1;
  int perPage = 10;
  bool isLoading = false;
  List<PerangkatSayaDataList> perangkatSayaDataDetails = [];

  void incrementPage() {
    page++;
    notifyListeners();
  }

  void showSpinner(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> updateDeviceListFuture(
    String token, {
    bool isPagination = false,
    required Function(String) showErrorSnackbar, // Error callback
  }) async {
    try {
      final newDevices = await getDeviceList(
        token,
        showErrorSnackbar,
        page,
        perPage,
      );

      if (isPagination) {
        perangkatSayaDataDetails.addAll(newDevices);
      } else {
        perangkatSayaDataDetails = newDevices;
      }

      notifyListeners();
    } catch (error) {
      showErrorSnackbar('Error: $error');
    }
  }

  Future<List<PerangkatSayaDataList>> getDeviceList(
    String token,
    Function(String) showErrorSnackbar,
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

    final Uri uri = Uri.parse("${API.baseUrl}/v1/device/lists");

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
        final PerangkatSayaResponse psResponse = PerangkatSayaResponse.fromJson(json);
        final Map<String, dynamic> messageData = psResponse.messageData as Map<String, dynamic>;

        if (messageData.isNotEmpty) {
          final PerangkatSayaData data = PerangkatSayaData.fromJson(psResponse.messageData);
          final List<PerangkatSayaDataList> devices = data.data;

          if (devices.isNotEmpty) {
            await LocalPrefs.saveDeviceKey(devices[0].pKey);
            await LocalPrefs.saveWhatsappNumber(devices[0].whatsappNumber);
          }

          return devices;
        } else {
          final String message = jsonDecode(response.body)["message_desc"];
          showErrorSnackbar('Error: ${response.statusCode} - ${psResponse.messageData.msg}');
          throw Exception(message);
        }
      } else {
        throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase} test');
      }
    } catch (error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw Exception(error.toString());
    }
  }

  Future<DeviceInfoResponse> getDeviceInfo(
    String token,
    String whatsappNumber,
    Function(String) showErrorSnackbar,
  ) async {
    final Uri uri = Uri.parse("${API.baseUrl}/api/v1/device/$whatsappNumber");
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
        return DeviceInfoResponse.fromJson(json);
      } else {
        final String message = jsonDecode(response.body)["message_desc"];
        showErrorSnackbar('Error: ${response.statusCode} - ${response.reasonPhrase}');

        throw Exception(message);
      }
    } catch (error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      showErrorSnackbar('Error: $error');
      throw Exception(error.toString());
    }
  }
}
