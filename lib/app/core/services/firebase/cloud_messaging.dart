import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:wasender/app/core/services/local_notifications/local_notifications.dart';
import 'package:wasender/app/core/services/navigation/navigation.dart';
import 'package:wasender/app/core/services/preferences.dart';
import 'package:logger/logger.dart';

class FirebaseCloudMessagingService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final logger = Logger();

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
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _onNotificationTap(message);
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _onNotificationTap(message);
      }
    });
  }

  static Future<void> onBackgroundMessage(RemoteMessage message) async {
    if (kDebugMode) {
      print('onMessage: ${message.data}');
      logger.i('onMessage: ${message.data}');
    }

    final String? chatId = message.data['chatId'];
    if (chatId != null) {
      // Navigate to active chat screen
      NavService.navigatorKey.currentState?.pushNamed(
        '/chat',
        arguments: {'chatId': chatId},
      );
    }

    final String? messageTitle = message.notification?.title;
    final String? messageBody = message.notification?.body;

    if (messageTitle != null && messageBody != null) {
      LocalNotificationsServices().showNotification(messageTitle, messageBody);
    }
  }

  static Future<void> onMessage(RemoteMessage message) async {
    if (kDebugMode) {
      print('onMessage: ${message.data}');
    }

    // Use the correct key 'room_chat'
    final String? roomChat = message.data['room_chat'] as String?;
    if (kDebugMode) {
      print('roomChat: $roomChat');
    }

    final String? messageTitle = message.notification?.title;
    final String? messageBody = message.notification?.body;

    if (messageTitle != null && messageBody != null) {
      LocalNotificationsServices().showNotification(messageTitle, messageBody);
    }
  }

  static Future<void> _onNotificationTap(RemoteMessage message) async {
    final notificationData = message.data;
    if (notificationData.containsKey('room_chat')) {
      final String? roomChat = notificationData['room_chat'] as String?;
      final screen = notificationData['screen'];
      await NavService.navigatorKey.currentState?.pushNamed(
        screen,
        arguments: {'room_chat': roomChat},
      );
      if (NavService.navigatorKey.currentState?.canPop() == true) {
        final currentRoute = ModalRoute.of(NavService.navigatorKey.currentContext!)?.settings.name;
        if (currentRoute != screen) {
          NavService.navigatorKey.currentState?.pushNamed(
            screen,
            arguments: {'room_chat': roomChat},
          );
        }
      }
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    final notificationData = message.data;
    if (notificationData.containsKey('room_chat') || (notificationData.containsKey('chatId'))) {
      final String? roomChat = notificationData['room_chat'] as String?;
      final screen = notificationData['screen'];
      NavService.navigatorKey.currentState?.pushNamed(
        screen,
        arguments: {'room_chat': roomChat},
      );
    }
  }

  static Future<void> requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
}
