import '../../../models/message.dart';

abstract class ChatEvent {}

class LoadMessages extends ChatEvent {
  final String senderId;
  final String receiverId;

  LoadMessages(this.senderId, this.receiverId);
}

class SendMessage extends ChatEvent {
  final Messages message;

  SendMessage(this.message);
}

class ReceiveMessage extends ChatEvent {
  final Messages message;

  ReceiveMessage(this.message);
}

class ReceiveMessages extends ChatEvent { // New event for multiple messages
  final List<Messages> messages;

  ReceiveMessages(this.messages);
}
