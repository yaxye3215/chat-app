import '../../../models/message.dart';

abstract class ChatState {

}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Messages> messages;

  ChatLoaded(this.messages);


}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message);

}
