import 'package:chat_app/models/contacts.dart';

import 'package:chat_app/pages/chat/ui/chat_page.dart';
import 'package:chat_app/pages/home/bloc/home_bloc.dart';
import 'package:chat_app/pages/home/ui/widgets/floating_btn_widget.dart';
import 'package:chat_app/pages/home/ui/widgets/list_tile_widget.dart';
import 'package:chat_app/utils/preference_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../response/socket_io.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;
  final SocketService socketService = SocketService();

  @override
  void initState() {
    super.initState();
    homeBloc = HomeBloc();
    homeBloc.add(HomeInitialEvent());
    socketService.connect();
  }

  @override
  void dispose() {
    homeBloc.close();
    socketService.socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chat Aopp"),
          elevation: 10,
          actions: [
            IconButton(
              onPressed: () async {
                PreferenceUtils.removeString("token");
                print("removed token");
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        floatingActionButton: const FloatingActionBtnWidget(),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeToChatPage) {
              final Contacts contact = state.contacts;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(contact: contact),
                ),
              ).then((_) {
                homeBloc.add(HomeInitialEvent());
              });
            }
          },
          builder: (context, state) {
            if (state is HomeSuccess) {
              final successData = state;
              return ListView.builder(
                itemCount: successData.contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  final contact = successData.contacts[index];
                  return ListTileWidget(
                    contacts: contact,
                    onTap: () async {
                      homeBloc.add(HomeToChatPageEvent(contacts: contact));
                    },
                  );
                },
              );
            } else if (state is HomeLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Loading....."),
                    SizedBox(height: 10),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text("Something is wrong"),
              );
            }
          },
        ),
      ),
    );
  }
}
