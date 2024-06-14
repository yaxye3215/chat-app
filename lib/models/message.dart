// To parse this JSON data, do
//
//     final messages = messagesFromJson(jsonString);
import 'dart:convert';

List<Messages> messagesFromJson(String str) =>
    List<Messages>.from(json.decode(str).map((x) => Messages.fromJson(x)));

String messagesToJson(List<Messages> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Messages {
  final String id;
  final String sender;
  final String receiver;
  final String content;
  final String messageType;
  final String mediaUrl;
  final String status;

  Messages({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.content,
    required this.messageType,
    required this.mediaUrl,
    required this.status,
  });

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        id: json["_id"],
        sender: json["sender"],
        receiver: json["receiver"],
        content: json["content"],
        messageType: json["messageType"],
        mediaUrl: json["mediaUrl"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender,
        "receiver": receiver,
        "content": content,
        "messageType": messageType,
        "mediaUrl": mediaUrl,
        "status": status,
      };
}
