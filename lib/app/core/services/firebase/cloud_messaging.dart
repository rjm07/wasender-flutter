import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import '../../../ui/pages/feature_main/feature_pages/menu/feature_pesan/chats/chat_screen.dart';
import 'package:wasender/app/core/services/navigation/navigation.dart';
import 'package:wasender/app/core/services/preferences.dart';

class FirebaseCloudMessagingService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final logger = Logger();
  Map<String, dynamic>? _latestNotificationData;

  Future<void> initialize() async {
    await Firebase.initializeApp();

    // Initialize local notifications
    const AndroidInitializationSettings androidInitSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(android: androidInitSettings);

    // await _flutterLocalNotificationsPlugin.initialize(initSettings,
    //     onDidReceiveNotificationResponse: _onNotificationResponse);

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationResponse, // Handles foreground/background clicks
    );

    // Request permissions for notifications
    if (Platform.isIOS) {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    await _saveFCMToken();
    _setupNotificationHandlers();
  }

  Future<void> _saveFCMToken() async {
    try {
      String? fcmToken = await _firebaseMessaging.getToken();
      if (fcmToken != null) {
        logger.i('FCM Token: $fcmToken');
        await LocalPrefs.saveFCMToken(fcmToken);
      } else {
        logger.w('FCM Token is null.');
      }
    } catch (e) {
      logger.e('Error saving FCM Token: $e');
    }
  }

  void _setupNotificationHandlers() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logger.i('Foreground Notification: ${message.notification?.title}');
      _showLocalNotification(message);
      handleUserTriggeredNavigation();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.i('Notification tapped (background): ${message.data}');
      _storeNotificationPayload(message.data);
      handleUserTriggeredNavigation();
    });

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        logger.i('Notification tapped (terminated): ${message.data}');
        _storeNotificationPayload(message.data);

        // ⚠️ Delay navigation until after the app is fully loaded
        Future.delayed(Duration(seconds: 1), () {
          handleUserTriggeredNavigation();
        });
      }
    });
  }

  void _showLocalNotification(RemoteMessage message) {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
      payload: message.data.toString(),
    );
  }

  void _onNotificationResponse(NotificationResponse response) {
    if (response.payload != null) {
      logger.i('Notification response payload: ${response.payload}');

      final Map<String, dynamic> data = jsonDecode(response.payload!) as Map<String, dynamic>;
      _storeNotificationPayload(data);
      handleUserTriggeredNavigation();
    } else {
      logger.w('Notification response payload is null.');
    }
  }

  void _storeNotificationPayload(Map<String, dynamic> data) {
    _latestNotificationData = data;
    logger.i('Stored notification data: $data');
  }

  void handleUserTriggeredNavigation() {
    if (_latestNotificationData != null) {
      final data = _latestNotificationData!;
      String roomChat = data['roomChat'] ?? '';
      String senderNumber = data['senderNumber'] ?? '';
      String fullName = data['fullname'] ?? '';
      String timestamp = data['timestamp'] ?? '';
      String status = data['status'] ?? 'OPEN';

      logger.i('Navigating to ChatScreen with data: $data and the status is: $status');

      NavService.push(
        screen: ChatScreen(
          fullName: fullName,
          timestamp: timestamp,
          roomChat: roomChat,
          senderNumber: senderNumber,
          statusIsOpen: status,
          onHandleTicket: () {},
        ),
      );

      _latestNotificationData = null; // Clear stored data
    } else {
      logger.w('No notification data available to navigate.');
    }
  }
}
