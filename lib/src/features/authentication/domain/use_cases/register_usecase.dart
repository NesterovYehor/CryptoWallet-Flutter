import 'package:crypto_track/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class AuthRegisterUseCase {
  final AuthRepository _authRepository;

  Future<void> call(Params params) async {
    return await _authRepository.register(params);
  }

  AuthRegisterUseCase(this._authRepository);
}

class Params extends Equatable {
  final String username;
  final String email;
  final String password;
  const Params({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        username,
        email,
        password,
      ];
}
