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

import '../../../ui/pages/feature_main/feature_pages/menu/feature_pesan/chats/chat_screen.dart';
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

  // await _firebaseMessaging.requestPermission(
  // alert: true,
  // badge: true,
  // sound: true,
  // );

  Future<void> initialize() async {
    // Request permissions for iOS

    if (Platform.isIOS) {
      String? apnsToken = await _firebaseMessaging.getAPNSToken();

      if (apnsToken != null) {
        _saveFCMToken();
      }
    } else {
      _saveFCMToken();
    }

    requestPermission();

    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        logger.i('Foreground Notification: ${message.notification?.title}');
      }
      handleNotificationPayload(message.data);
    });

    // Handle background notifications
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.i('Notification tapped when app in background: ${message.data}');
      handleNotificationPayload(message.data);
    });

    // Handle notification when the app is terminated
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      logger.i('Notification tapped when app is closed: ${initialMessage.data}');
      handleNotificationPayload(initialMessage.data);
    }

    // Log the FCM token for testing/debugging purposes
    String? token = await _firebaseMessaging.getToken();
    logger.i('FCM Token: $token');
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

  void handleNotificationPayload(Map<String, dynamic> data) {
    if (data.containsKey('roomChat') && data.containsKey('senderNumber')) {
      String roomChat = data['roomChat'] ?? '';
      String senderNumber = data['senderNumber'] ?? '';
      String fullName = data['fullname'] ?? '';
      String timestamp = data['timestamp'] ?? '';

      logger.i('Navigating to ChatScreen with data: $data');

      NavService.navigatorKey.currentState?.pushNamed(
        ChatScreen.routeName,
        arguments: {
          'room_chat': roomChat,
          'senderNumber': senderNumber,
          'fullname': fullName,
          'timestamp': timestamp,
        },
      );
    } else {
      logger.w('Notification payload missing required data: $data');
    }
  }
}
