import 'package:crypto_track/src/features/authentication/domain/repositories/auth_repository.dart';

class AuthLogoutUseCase{
  final AuthRepository _authRepository;

  Future<void> call() async {
    return await _authRepository.logout();
  }

    AuthLogoutUseCase(this._authRepository);

}