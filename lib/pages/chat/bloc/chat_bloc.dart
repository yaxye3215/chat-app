import 'package:bloc/bloc.dart';
import '../../../models/message.dart';
import '../../../response/socket_io.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SocketService socketService;
  final List<Messages> _messages = [];

  ChatBloc(this.socketService) : super(ChatInitial()) {
    on<LoadMessages>((event, emit) async {
      emit(ChatLoading());
      try {
        socketService.getMessages(event.senderId, event.receiverId);
      } catch (e) {
        emit(ChatError('Failed to load messages'));
      }
    });

    on<SendMessage>((event, emit) {
      socketService.sendMessage(
          event.message.sender, event.message.receiver, event.message.content);
      // _messages.add(event.message);
      emit(ChatLoaded(List.from(_messages)));
      // Emit ReceiveMessage to update the state for the sent message
      add(ReceiveMessage(event.message));
    });

    on<ReceiveMessage>((event, emit) {
      _messages.add(event.message);
      emit(ChatLoaded(List.from(_messages)));
    });

    on<ReceiveMessages>((event, emit) {
      // Handle multiple messages
      _messages.addAll(event.messages);
      emit(ChatLoaded(List.from(_messages)));
    });

    socketService.messageStream.listen((messages) {
      add(ReceiveMessages(messages));
    });
  }
}

/*

    on<SendMessage>((event, emit) {
      // Assuming the UI already optimistically adds the message to _messages
      // and this event is mainly for sending over socket and updating state
      socketService.sendMessage(
        event.message.sender,
        event.message.receiver,
        event.message.content,
      );
      emit(ChatSending()); // Optional state for indicating sending in progress
    });

    on<ReceiveMessage>((event, emit) {
      _messages.add(event.message);
      emit(ChatLoaded(List.from(_messages)));
    });

    socketService.messageStream.listen((messages) {
      _messages = messages;
      emit(ChatLoaded(List.from(_messages)));
    });
  }

  @override
  Future<void> close() {
    socketService.dispose();
    return super.close();
  }
}

*/
