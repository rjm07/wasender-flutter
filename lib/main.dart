import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasender/app/app.dart';
import 'package:wasender/app/core/services/firebase/cloud_messaging.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_dashboard/dashboard_screen.dart';
import 'dart:io';

import 'app/core/services/auth.dart';
import 'app/core/services/fcm.dart';
import 'app/core/services/local_notifications/local_notifications.dart';
import 'app/core/services/perangkat_saya/perangkat_saya.dart';
import 'app/core/services/pesan/pesan.dart';
import 'app/core/services/socket_io/socket.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalNotificationsServices.init();
  await FirebaseCloudMessagingService.init();

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
      ],
      child: const WhatUpApp(),
    ),
  );
}

//to run in dev mode
//flutter run --dart-define-from-file=.env/dev.json
