import 'package:chat_app/pages/chat/bloc/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/contacts.dart';
import '../../../models/message.dart';
import '../../../response/socket_io.dart';

import '../../../utils/preference_utils.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.contact});
  final Contacts contact;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatBloc chatBloc;
  final userId = PreferenceUtils.getString("id");
  final TextEditingController _messageController = TextEditingController();
  final socketService = SocketService();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    if (!socketService.isConnected) {
      socketService.connect();
      socketService.joinRoom(userId);
    }

    chatBloc = ChatBloc(socketService);
    chatBloc.add(LoadMessages(userId, widget.contact.id));
  }

  @override
  void dispose() {
    chatBloc.close();
    socketService.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      final message = Messages(
        id: DateTime.now().toString(),
        sender: userId,
        receiver: widget.contact.id,
        content: _messageController.text,
        messageType: 'text',
        mediaUrl: '',
        status: 'sent',
      );
      chatBloc.add(SendMessage(message));
      _messageController.clear();
      scrollToBottom();
    }
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chatBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.contact.name),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChatLoaded) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      scrollToBottom(); // Ensure initial scroll to bottom
                    });
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        bool isSentByUser = message.sender == userId;
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          alignment: isSentByUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isSentByUser
                                  ? Colors.blue[100]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(message.content),
                          ),
                        );
                      },
                    );
                  } else if (state is ChatError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your message',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
