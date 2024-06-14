import 'dart:async';
import 'dart:convert';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../models/message.dart';

class SocketService {
  late IO.Socket socket;
  final StreamController<List<Messages>> _messageController =
      StreamController.broadcast();
  bool isConnected = false;

  Stream<List<Messages>> get messageStream => _messageController.stream;

  void connect() {
    if (isConnected) return;

    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('connect', (_) {
      isConnected = true;

      ///  print('Connected to socket server');
    });

    socket.on('disconnect', (_) {
      isConnected = false;
      // print('Disconnected from socket server');
    });

    socket.on('receiveMessage', (data) {
      //   print('Message received: $data');
      final message = Messages.fromJson(data);
      if (!_messageController.isClosed) {
        _messageController.add([message]);
      }
    });

    socket.on('messageHistory', (data) {
      final messages = messagesFromJson(json.encode(data));
      if (!_messageController.isClosed) {
        _messageController.add(messages);
      }
    });

    socket.on('error', (error) {
      //  print('Socket error: $error');
    });
  }

  void sendMessage(String senderId, String receiverId, String content) {
    socket.emit('sendMessage', {
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'messageType': 'text',
      'mediaUrl': ''
    });
  }

  void getMessages(String senderId, String receiverId) {
    socket.emit('getMessages', {
      'senderId': senderId,
      'receiverId': receiverId,
    });
  }

  void joinRoom(String userId) {
    socket.emit('joinRoom', userId);
  }

  void dispose() {
    _messageController.close();
    socket.dispose();
  }
}
