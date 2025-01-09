import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

import '../preferences.dart';

class SocketService {
  final logger = Logger();
  static final SocketService _instance = SocketService._internal();
  socket_io.Socket? _socket;

  factory SocketService() {
    return _instance;
  }

  SocketService._internal();
  socket_io.Socket initializeSocket() {
    _socket = socket_io.io('https://whatup.id:4901', {
      'transports': ['websocket'],
      'forceNew': true,
      'autoConnect': true,
      'reconnectionAttempts': 5,
    });
    _socket!.connect();
    logger.i('Connection to event server established');
    _socket?.on("disconnect", (_) => logger.e('Disconnected'));
    _socket?.on('chat', (data) => logger.e('Chat: $data'));
    _socket!.on('connect', (_) {
      logger.i('Socket connected successfully');
    });
    _socket!.on('error', (data) {
      logger.e('Socket error: $data');
    });
    _socket!.on('connect_error', (data) {
      logger.e('Connection error: $data');
    });
    return _socket!;
  }

  void listen(bool isBot, Function(dynamic) callback) async {
    final String? deviceKey = await LocalPrefs.getDeviceKey();
    final String? fkUserID = await LocalPrefs.getFKUserID();

    if (kDebugMode) {
      logger.i("Socket: Connecting to something");
    }

    logger.i("Socket: Connected");
    if (isBot) {
      final event = "bot:$deviceKey";
      _socket?.on(event, callback);
      logger.i("Socket: Listening to $event");
      return;
    } else {
      final event = "popup:${fkUserID}_$deviceKey";
      _socket?.on(event, callback);
      logger.i("Socket: Listening to $event");
    }
  }

  void dispose() {
    _socket?.disconnect();
    _socket = null;
  }

  void closeSocket() {
    _socket!.close();
  }

  void disconnectSocket() {
    _socket!.disconnect();
  }
}
