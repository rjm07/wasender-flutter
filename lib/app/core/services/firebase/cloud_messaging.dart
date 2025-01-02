import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:wasender/app/core/services/local_notifications/local_notifications.dart';
import 'package:wasender/app/core/services/preferences.dart';

class FirebaseCloudMessagingService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> _saveFCMToken() async {
    String? fcmToken = await _firebaseMessaging.getToken();

    if (fcmToken != null) {
      if (kDebugMode) {
        print('FCM Token: $fcmToken');
      }
      LocalPrefs.saveFCMToken(fcmToken);
    }
  }

  static Future<void> init() async {
    if (Platform.isIOS) {
      String? apnsToken = await _firebaseMessaging.getAPNSToken();

      if (apnsToken != null) {
        _saveFCMToken();
      }
    } else {
      _saveFCMToken();
    }

    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    FirebaseMessaging.onMessage.listen(onMessage);
  }

  static Future<void> onBackgroundMessage(RemoteMessage message) async {
    if (kDebugMode) {
      print('onBackgroundMessage: $message');
    }
  }

  static Future<void> onMessage(RemoteMessage message) async {
    if (kDebugMode) {
      print('onMessage: $message');
    }

    final String? messageTitle = message.notification?.title;
    final String? messageBody = message.notification?.body;

    if (messageTitle != null && messageBody != null) {
      LocalNotificationsServices().showNotification(messageTitle, messageBody);
    }
  }

  static Future<void> requestPermission() async {
    await _firebaseMessaging.requestPermission();
  }
}
