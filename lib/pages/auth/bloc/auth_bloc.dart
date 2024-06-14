import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/pages/auth/resp/auth_resp.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInEvent>(signInEvent);
    on<SignUpEvent>(signUpEvent);
    on<NavigateToRegisterEvent>(navigateToRegisterEvent);
    on<NavigateToLoginEvent>(navigateToLoginEvent);
  }
  FutureOr<void> signInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      await AuthResp().signIn(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError());
    }
  }

  FutureOr<void> signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      await AuthResp().signUp(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError());
    }
  }

  FutureOr<void> navigateToRegisterEvent(
      NavigateToRegisterEvent event, Emitter<AuthState> emit) {
    emit(AuthNavigateToRegister());
  }

  FutureOr<void> navigateToLoginEvent(
      NavigateToLoginEvent event, Emitter<AuthState> emit) {
    emit(AuthNavigateToLogin());
  }
}
