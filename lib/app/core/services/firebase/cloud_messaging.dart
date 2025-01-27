import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wasender/app/core/services/navigation/navigation.dart';
import 'package:wasender/app/core/services/preferences.dart';
import 'package:logger/logger.dart';

import '../../../ui/pages/feature_main/feature_pages/menu/feature_pesan/chats/chat_screen.dart';

class FirebaseCloudMessagingService {
  Map<String, dynamic>? _latestNotificationData;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final logger = Logger();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showForegroundNotification(RemoteMessage message) {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }

  Future<void> initialize() async {
    await Firebase.initializeApp();

    // Request permissions for notifications
    if (Platform.isIOS) {
      String? apnsToken = await _firebaseMessaging.getAPNSToken();

      if (apnsToken != null) {
        _saveFCMToken();
      }
    } else {
      _saveFCMToken();
    }

    requestPermission();

    // Save FCM Token
    await _saveFCMToken();

    // Set up notification handlers
    _setupNotificationHandlers();
  }

  /// Request notification permissions
  static Future<void> requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      logger.i('User granted notification permissions.');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      logger.i('User granted provisional notification permissions.');
    } else {
      logger.w('User declined or has not accepted notification permissions.');
    }
  }

  /// Save the FCM token locally
  Future<void> _saveFCMToken() async {
    try {
      String? fcmToken = await _firebaseMessaging.getToken();
      if (fcmToken != null) {
        logger.i('FCM Token: $fcmToken');
        // Replace with your method for saving the token
        // LocalPrefs.saveFCMToken(fcmToken);
      } else {
        logger.w('FCM Token is null. Unable to register for notifications.');
      }
    } catch (e) {
      logger.e('Error while getting FCM Token: $e');
    }
  }

  /// Set up notification handlers
  void _setupNotificationHandlers() {
    // Foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        logger.i('Foreground Notification: ${message.notification?.title}');
        showForegroundNotification(message);
      }
      // _storeNotificationPayload(message.data);
      // handleUserTriggeredNavigation();
    });

    // Background notification tap
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.i('Notification tapped while in background: ${message.data}');
      _storeNotificationPayload(message.data);
      handleUserTriggeredNavigation();
    });

    // Notification when app is terminated
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? initialMessage) {
      if (initialMessage != null) {
        logger.i('Notification tapped when app was terminated: ${initialMessage.data}');
        _storeNotificationPayload(initialMessage.data);
        handleUserTriggeredNavigation();
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.i('Notification tapped when app was in background: ${message.data}');
      _storeNotificationPayload(message.data);
      handleUserTriggeredNavigation();
    });
  }

  /// Store notification payload for user interaction
  void _storeNotificationPayload(Map<String, dynamic> data) {
    _latestNotificationData = data;
    logger.i('Stored notification data: $data');
  }

  /// Handle user-triggered navigation
  void handleUserTriggeredNavigation() {
    final data = _latestNotificationData!;
    debugPrint('data: $data');
    if (data['roomChat'] != null || data['senderNumber'] != null) {
      String roomChat = data['roomChat'] ?? '';
      String senderNumber = data['senderNumber'] ?? '';
      String fullName = data['fullname'] ?? '';
      String timestamp = data['timestamp'] ?? '';

      logger.i('Navigating to ChatScreen with data: $data');

      NavService.push(
          screen: ChatScreen(
              fullName: fullName,
              timestamp: timestamp,
              roomChat: roomChat,
              senderNumber: senderNumber,
              statusIsOpen: false,
              onHandleTicket: () {}));

      // navigatorKey.currentState?.pushNamed(
      //   ChatScreen.routeName,
      //   arguments: {
      //     'room_chat': roomChat,
      //     'senderNumber': senderNumber,
      //     'fullname': fullName,
      //     'timestamp': timestamp,
      //   },
      // );

      // Clear stored data after handling
      _latestNotificationData = null;
    } else {
      logger.w('Notification payload missing required fields: $data');
    }

    if (_latestNotificationData != null) {
    } else {
      logger.w('No notification data available to navigate.');
    }
  }
}

// class FirebaseCloudMessagingService {
//   static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//   static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   static final logger = Logger();
//
//   static Future<void> _saveFCMToken() async {
//     String? fcmToken = await _firebaseMessaging.getToken();
//
//     if (fcmToken != null) {
//       if (kDebugMode) {
//         print('FCM Token: $fcmToken');
//         print('I went here');
//       }
//       LocalPrefs.saveFCMToken(fcmToken);
//     }
//   }
//
//   Future<void> initialize() async {
//     // Request permissions for iOS
//
//     if (Platform.isIOS) {
//       String? apnsToken = await _firebaseMessaging.getAPNSToken();
//
//       if (apnsToken != null) {
//         _saveFCMToken();
//       }
//     } else {
//       _saveFCMToken();
//     }
//
//     requestPermission();
//
//     // Handle foreground notifications
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (message.notification != null) {
//         logger.i('Foreground Notification: ${message.notification?.title}');
//       }
//
//       handleNotificationPayload(message.data);
//     });
//
//     // Handle background notifications
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       logger.i('Notification tapped when app in background: ${message.data}');
//       handleNotificationPayload(message.data);
//     });
//
//     // Handle notification when the app is terminated
//     RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
//     if (initialMessage != null) {
//       logger.i('Notification tapped when app is closed: ${initialMessage.data}');
//       handleNotificationPayload(initialMessage.data);
//     }
//
//     // Log the FCM token for testing/debugging purposes
//     String? token = await _firebaseMessaging.getToken();
//     logger.i('FCM Token: $token');
//   }
//
//   static Future<void> requestPermission() async {
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       if (kDebugMode) {
//         print('User granted permission');
//       }
//     } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//       if (kDebugMode) {
//         print('User granted provisional permission');
//       }
//     } else {
//       if (kDebugMode) {
//         print('User declined or has not accepted permission');
//       }
//     }
//   }
//
//   void handleNotificationPayload(Map<String, dynamic> data) {
//     if (data.containsKey('roomChat') && data.containsKey('senderNumber')) {
//       String roomChat = data['roomChat'] ?? '';
//       String senderNumber = data['senderNumber'] ?? '';
//       String fullName = data['fullname'] ?? '';
//       String timestamp = data['timestamp'] ?? '';
//
//       logger.i('Navigating to ChatScreen with data: $data');
//
//       NavService.navigatorKey.currentState?.pushNamed(
//         ChatScreen.routeName,
//         arguments: {
//           'room_chat': roomChat,
//           'senderNumber': senderNumber,
//           'fullname': fullName,
//           'timestamp': timestamp,
//         },
//       );
//     } else {
//       logger.w('Notification payload missing required data: $data');
//     }
//   }
// }
