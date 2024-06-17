part of 'authentication_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  final bool isLoading;
  final String? loadingText;

  const AuthState({required this.isLoading, this.loadingText = 'Please wait a moment'});

  @override
  List<Object?> get props => [isLoading, loadingText];
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required bool isLoading}) : super(isLoading: isLoading);
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading({required bool isLoading, String? loadingText})
      : super(isLoading: isLoading, loadingText: loadingText);
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;

  const AuthStateRegistering({required this.exception, required isLoading}) : super(isLoading: isLoading);

  @override
  List<Object?> get props => [exception, isLoading];
}

class AuthStateLoggedIn extends AuthState {
  final User user;

  const AuthStateLoggedIn({required this.user, required bool isLoading}) : super(isLoading: isLoading);

  @override
  List<Object?> get props => [user, isLoading];
}

class AuthStateLoggedOut extends AuthState {
  final Exception? exception;

  const AuthStateLoggedOut({required this.exception, required bool isLoading, String? loadingText})
      : super(isLoading: isLoading, loadingText: loadingText);

  @override
  List<Object?> get props => [exception, isLoading];
}
