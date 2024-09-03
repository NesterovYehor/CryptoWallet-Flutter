import 'package:crypto_track/src/configs%20/injector/injector.dart';

import '../../../../core/errors/exceptions.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/models/login_model.dart';
import '../../data/models/register_model.dart';
import '../../domain/entities/user_entitie.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/auth_use_cases.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  final LocalStorage _secureLocalStorage;
  final LocalStorage _localStorage;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource, this._secureLocalStorage, this._localStorage);

  @override
  Future<UserEntity?> checkSignInStatus() async {
    try {
      return await _localDataSource.checkSignInStatus();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> logIn(LoginParams params) async {
    try {
      final model = LoginModel(email: params.email, password: params.password);

      final result = await _remoteDataSource.login(model);

      await _secureLocalStorage.save(key: "user_id", value: result.userId);
      await _localStorage.save(key: "user", value: result, boxName: "cache");

      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _remoteDataSource.logout();

      await _secureLocalStorage.delete(key: "user_id");
      await _localStorage.delete(key: "user", boxName: "cache");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> register(RegisterParams params) async {
    try {
      final model = RegisterModel(
          username: params.username,
          email: params.email,
          password: params.password);
      await _remoteDataSource.register(model);
    } on DuplicateEmailException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
