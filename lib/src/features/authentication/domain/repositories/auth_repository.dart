import '../entities/user_entitie.dart';
import '../use_cases/auth_use_cases.dart';

abstract class AuthRepository {
  Future<UserEntity> logIn(LoginParams params);
  Future<void> logout();
  Future<void> register(RegisterParams params);
  Future<UserEntity?> checkSignInStatus();
}