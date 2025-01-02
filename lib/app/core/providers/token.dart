// import 'dart:convert';
//
// import 'package:crypto/crypto.dart';
// import 'package:flutter/material.dart';
//
// import '../../utils/lang/strings.dart';

// class TokenGenerator {
//   static ({int requestId, String token}) generate(String sequence) {
//     final int requestId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//     final String tempToken = "SOCOM%|%$requestId%|%${API.socomKey}%|%${API.socomSec}%|%${API.hashKey}%|%$sequence";
//     final token = sha256.convert(utf8.encode(tempToken)).toString();
//     debugPrint("Temp Token: $tempToken");
//     debugPrint("Token: $token");
//     debugPrint("Request Id: $requestId");
//     debugPrint("Sequence: $sequence");
//
//     return (requestId: requestId, token: token);
//   }
// }
