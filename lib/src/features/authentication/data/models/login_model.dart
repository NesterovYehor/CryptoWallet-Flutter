import '../../domain/entities/user_entitie.dart';

class LoginModel extends UserEntity {
  const LoginModel({
    required String email,
    required String password,
  }) : super(email: email, password: password);

  LoginModel copyWith({String? email, String? password}) {
    return LoginModel(
      email: email ?? (this.email ?? ""),
      password: password ?? (this.password ?? ""),
    );
  }
}