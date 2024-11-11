import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wasender/app/app.dart';

import 'core/services/auth.dart';
import 'core/services/local_notifications/local_notifications.dart';
import 'core/services/perangkat_saya/perangkat_saya.dart';
import 'core/services/pesan/pesan.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.request();
  await LocalNotificationsServices.init();

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
