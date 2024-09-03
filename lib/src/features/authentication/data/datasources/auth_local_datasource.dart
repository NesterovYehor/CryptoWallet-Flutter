import 'package:crypto_track/src/configs%20/injector/injector.dart';
import 'package:crypto_track/src/core/errors/exceptions.dart';
import 'package:crypto_track/src/core/utils/logger.dart';
import 'package:crypto_track/src/features/authentication/domain/entities/user_entitie.dart';

sealed class AuthLocalDataSource {
  Future<UserEntity?> checkSignInStatus();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorage _secureLocalStorage;
  final LocalStorage _localStorage;
  const AuthLocalDataSourceImpl(
    this._secureLocalStorage,
    this._localStorage,
  );



  @override
  Future<UserEntity?> checkSignInStatus() async {
    try {
      final userId = await _secureLocalStorage.load(key: "user_id");
      final result = await _localStorage.load(key: "user", boxName: "cache");
      if (result != null && userId.isNotEmpty) {
        if (result is UserEntity) {
          return result;
        }
      }

      return null;
    } catch (e) {
      logger.e(e);
      throw CacheException();
    }
  }
}