part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

// ignore: must_be_immutable
class HomeInitialEvent extends HomeEvent {}

// click user to chat page
class HomeToChatPageEvent extends HomeEvent {
  final Contacts contacts;

  HomeToChatPageEvent({required this.contacts});
}
