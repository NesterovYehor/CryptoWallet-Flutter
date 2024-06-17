import 'package:bloc/bloc.dart';
import 'package:crypto_track/domain/use_cases/auth_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'authentication_bloc_event.dart';
part 'authentication_bloc_state.dart';

class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {
  final LogInUseCase _logIn;
  final SignUpUseCase _signUp;
  final LogOutUseCase _logOut;
  final GetCurrentUserUseCase _getCurrentUser;

  AuthenticationBloc(
    this._logIn, 
    this._signUp, 
    this._logOut, 
    this._getCurrentUser) : super(const AuthStateUninitialized(isLoading: true)) {
    on<AuthEventInitialize>((event, emit){
      try {
        final user = _getCurrentUser.call();
        if (user != null) {
          emit(AuthStateLoggedIn(user: user, isLoading: false));
        } else {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
        }
      } catch (e) {
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      }
    });

    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoading(isLoading: true, loadingText: 'Logging in...'));
      try {
        final user = await _logIn.call(event.email, event.password);
        emit(AuthStateLoggedIn(user: user!, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });

    on<AuthEventRegister>((event, emit) async {
      emit(const AuthStateLoading(isLoading: true, loadingText: 'Registering...'));
      try {
        final user = await _signUp.call(event.email, event.password, "");
        emit(AuthStateLoggedIn(user: user!, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateRegistering(exception: e, isLoading: false));
      }
    });

    on<AuthEventLogOut>((event, emit) async {
      emit(const AuthStateLoading(isLoading: true, loadingText: 'Logging out...'));
      try {
        await _logOut.call();
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });
  }
}
