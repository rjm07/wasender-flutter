import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

import '../../../utils/lang/strings.dart';

class SocketService {
  final logger = Logger();
  late socket_io.Socket? socket;

  socket_io.Socket initializeSocket() {
    socket = socket_io.io(API.socketUrl, {
      'transports': ['websocket'],
      'forceNew': true,
      'autoConnect': true,
      'reconnectionAttempts': 5,
    });
    socket!.connect();
    debugPrint('Connection established');
    logger.i('Connection to server established');
    socket?.on("disconnect", (_) => logger.e('Disconnected'));
    socket?.on('chat', (data) => logger.e('Chat: $data'));
    return socket!;
  }

  void closeSocket() {
    socket!.close();
  }

  void disconnectSocket() {
    socket!.disconnect();
  }
}
