import 'dart:convert';

import 'package:chat_app/utils/utils.dart';
import 'package:http/http.dart' as http;

import '../../../models/message.dart';

class ChatResponse {
  // get Conversation
  Future<Messages> getConversation(
      {required String sender, required String receiver}) async {
    try {
      final response = await http.post(
        Uri.parse("$LOCAL/user/getmessage"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "sender": sender,
          "receiver": receiver,
        }),
      );

      if (response.statusCode == 200) {
        final message = Messages.fromJson(json.decode(response.body));
        return message;
      } else {
        throw Exception('Failed to load Message');
      }
    } catch (e) {
      // print('Error: $e');
      rethrow;
    }
  }
}
