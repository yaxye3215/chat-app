part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  SignInEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  SignUpEvent(
      {required this.name, required this.email, required this.password});
}

class LogoutEvent extends AuthEvent {}

// naviagtor
class NavigateToRegisterEvent extends AuthEvent {}

class NavigateToLoginEvent extends AuthEvent {}
