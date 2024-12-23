import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasender/app/app.dart';
import 'package:wasender/app/core/services/firebase/cloud_messaging.dart';
import 'dart:io';

import 'core/services/auth.dart';
import 'core/services/local_notifications/local_notifications.dart';
import 'core/services/perangkat_saya/perangkat_saya.dart';
import 'core/services/pesan/pesan.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalNotificationsServices.init();

  await FirebaseCloudMessagingService.init();

  HttpOverrides.global = MyHttpOverrides();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider<PerangkatSayaServices>(
          create: (_) => PerangkatSayaServices(),
        ),
        ChangeNotifierProvider<PesanServices>(
          create: (_) => PesanServices(),
        ),
      ],
      child: const WaSenderApp(),
    ),
  );
}

//to run in dev mode
//flutter run --dart-define-from-file=.env/dev.json
