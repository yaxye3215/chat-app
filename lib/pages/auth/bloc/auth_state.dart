part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthError extends AuthState {}

final class AuthLogout extends AuthState {}

// naviagtor
final class AuthNavigateToHome extends AuthState {}

final class AuthNavigateToLogin extends AuthState {}

final class AuthNavigateToRegister extends AuthState {}
