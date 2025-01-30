import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:wasender/app/app.dart';
import 'package:wasender/app/core/services/firebase/cloud_messaging.dart';
import 'package:wasender/app/core/services/profile/profile_services.dart';
import 'dart:io';

import 'app/core/services/auth.dart';
import 'app/core/services/fcm.dart';
import 'app/core/services/local_notifications/local_notifications.dart';
import 'app/core/services/perangkat_saya/perangkat_saya.dart';
import 'app/core/services/pesan/pesan.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  if (message.notification != null) {
    print(
        'On Background: ${message.notification?.title}/${message.notification!.body}/${message.notification!.titleLocKey}');
  }
  print('Received background message ${message.messageId}');
  return Future.value(true);
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  //await LocalNotificationsServices.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseCloudMessagingService fcmService = FirebaseCloudMessagingService();
  await fcmService.initialize();
  HttpOverrides.global = MyHttpOverrides();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider<FCMServices>(
          create: (_) => FCMServices(),
        ),
        ChangeNotifierProvider<PerangkatSayaServices>(
          create: (_) => PerangkatSayaServices(),
        ),
        ChangeNotifierProvider<PesanServices>(
          create: (_) => PesanServices(),
        ),
        ChangeNotifierProvider<ProfileServices>(
          create: (_) => ProfileServices(),
        ),
      ],
      child: const WhatUpApp(),
    ),
  );
}

//to run in dev mode
//flutter run --dart-define-from-file=.env/dev.json
