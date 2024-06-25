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
  const AuthStateUninitialized({required super.isLoading});
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading({required super.isLoading, super.loadingText = null});
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;

  // ignore: use_super_parameters
  const AuthStateRegistering({required this.exception, required isLoading}) : super(isLoading: isLoading);

  @override
  List<Object?> get props => [exception, isLoading];
}

class AuthStateLoggedIn extends AuthState {
  final User user;

  const AuthStateLoggedIn({required this.user, required super.isLoading});

  @override
  List<Object?> get props => [user, isLoading];
}

class AuthStateLoggedOut extends AuthState {
  final Exception? exception;

  const AuthStateLoggedOut({required this.exception, required super.isLoading, super.loadingText = null});

  @override
  List<Object?> get props => [exception, isLoading];
}
