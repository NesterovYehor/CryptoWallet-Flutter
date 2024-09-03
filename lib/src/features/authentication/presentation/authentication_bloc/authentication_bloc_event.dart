import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckSignInStatusEvent extends AuthEvent {
  const AuthCheckSignInStatusEvent();
}

class AuthLogInEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLogInEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class AuthRegisterEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;

  const AuthRegisterEvent(this.username, this.email, this.password);

  @override
  List<Object?> get props => [username, email, password];
}

class AuthLogOutEvent extends AuthEvent {
  const AuthLogOutEvent();
}
