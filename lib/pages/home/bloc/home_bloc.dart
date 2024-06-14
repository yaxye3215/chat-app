import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/pages/home/resp/heme_resp.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../models/contacts.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeToChatPageEvent>(homeToChatPageEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoading());
    //  print("Home initial");
      List<Contacts> contacts = await HomeResponse().getUsers();
      emit(HomeSuccess(contacts: contacts));
      // print(users.length);
    } catch (e) {
      // print(e.toString());
    }
  }

  FutureOr<void> homeToChatPageEvent(
      HomeToChatPageEvent event, Emitter<HomeState> emit) {
    emit(HomeToChatPage(contacts: event.contacts));
  }
}
