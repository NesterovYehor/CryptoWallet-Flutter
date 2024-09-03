import 'package:crypto_track/src/features/authentication/domain/entities/user_entitie.dart';
import 'package:crypto_track/src/features/authentication/domain/repositories/auth_repository.dart';

class AuthCheckSignInStatusUseCase {
  final AuthRepository _authRepository;
  const AuthCheckSignInStatusUseCase(this._authRepository);

  Future<UserEntity?> call() async {
    try {
      return await _authRepository.checkSignInStatus();
    } catch (e) {
      rethrow;
    }
  }
}