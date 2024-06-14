part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

// ignore: must_be_immutable
final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

// ignore: must_be_immutable
final class HomeSuccess extends HomeState {
  List<Contacts> contacts;

  HomeSuccess({required this.contacts});
}

final class HomeFailure extends HomeState {}

//naviagtion
final class HomeToChatPage extends HomeState {
  final Contacts contacts;

  HomeToChatPage({required this.contacts});
}
