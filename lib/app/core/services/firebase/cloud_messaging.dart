import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:wasender/app/core/services/local_notifications/local_notifications.dart';
import 'package:wasender/app/core/services/navigation/navigation.dart';
import 'package:wasender/app/core/services/preferences.dart';
import 'package:logger/logger.dart';

import '../../models/dashboard/dashboard_response.dart';
import '../fcm.dart';

class FirebaseCloudMessagingService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final logger = Logger();

  static Future<void> _saveFCMToken() async {
    String? fcmToken = await _firebaseMessaging.getToken();

    if (fcmToken != null) {
      if (kDebugMode) {
        print('FCM Token: $fcmToken');
        print('I went here');
      }
      LocalPrefs.saveFCMToken(fcmToken);
    }
  }

  static Future<void> init() async {
    await Firebase.initializeApp();
    if (Platform.isIOS) {
      String? apnsToken = await _firebaseMessaging.getAPNSToken();

      if (apnsToken != null) {
        _saveFCMToken();
      }
    } else {
      _saveFCMToken();
    }
    requestPermission();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.i('Notification tapped: ${message.data}');
      _onNotificationTap(message); // Trigger the navigation logic
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

    // Trigger navigation or logic tied to the notification
    _onNotificationTap(message);

    // Optionally display a local notification
    final String? messageTitle = message.notification?.title;
    final String? messageBody = message.notification?.body;

    if (messageTitle != null && messageBody != null) {
      LocalNotificationsServices().showNotification(messageTitle, messageBody);
    }
  }

  static Future<void> _onNotificationTap(RemoteMessage message) async {
    final notificationData = message.data;
    logger.i('Notification tapped: $notificationData');

    if (notificationData.containsKey('room_chat')) {
      final String? roomChat = notificationData['room_chat'];
      final String? timestamp = notificationData['timestamp'];
      final screen = notificationData['screen'];

      if (roomChat != null) {
        logger.i('Navigating to: $screen with roomChat: $roomChat');
        NavService.navigatorKey.currentState?.pushNamed(
          screen,
          arguments: {
            'room_chat': roomChat,
            'timestamp': timestamp,
          },
        );
      } else {
        logger.e('Error: Missing room_chat or screen');
      }
    } else {
      logger.e('Error: Notification data does not contain valid keys');
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    final notificationData = message.data;
    final String? timestamp = notificationData['timestamp'];
    logger.i('notificationData: ${message.data}');
    if (notificationData.containsKey('room_chat')) {
      final String? roomChat = notificationData['room_chat'] as String?;
      final screen = notificationData['screen'];
      NavService.navigatorKey.currentState?.pushNamed(
        screen,
        arguments: {
          'room_chat': roomChat,
          'timestamp': timestamp,
        },
      );
    }
    final String? messageTitle = message.notification?.title;
    final String? messageBody = message.notification?.body;

    if (messageTitle != null && messageBody != null) {
      LocalNotificationsServices().showNotification(messageTitle, messageBody);
    }
  }

  static Future<void> requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('User granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        print('User declined or has not accepted permission');
      }
    }
  }

  static void notificationSetup(RemoteMessage message) {
    final String? roomChat = message.data['room_chat'];
    final String? timestamp = message.data['timestamp'];
    final screen = message.data['screen'];

    if (roomChat != null && screen != null) {
      logger.i('Navigating to: $screen with roomChat: $roomChat');
      NavService.navigatorKey.currentState?.pushNamed(
        screen,
        arguments: {
          'room_chat': roomChat,
          'timestamp': timestamp,
        },
      );
    }
  }
}
