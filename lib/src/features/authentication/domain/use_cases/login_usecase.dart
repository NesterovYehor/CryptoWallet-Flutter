import 'package:crypto_track/src/features/authentication/domain/entities/user_entitie.dart';
import 'package:crypto_track/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class AuthLoginUseCase{
  final AuthRepository _repository;

  Future<UserEntity> call(Params params) async{
    final result = await _repository.logIn(params);
    return result; 
  }

  AuthLoginUseCase(this._repository);
}

class Params extends Equatable {
  final String email; 
  final String password;
  const Params({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}