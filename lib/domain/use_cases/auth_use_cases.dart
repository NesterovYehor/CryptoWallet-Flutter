import 'package:crypto_track/domain/interfaces/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogInUseCase{
  final AuthRepository repository;
  Future<User?> call(String email, String password)async{
    final user = await repository.logIn(email, password);
    return user;
  }
  LogInUseCase({required this.repository});
}

class SignUpUseCase{
  final AuthRepository repository;
  Future<User?> call(String email, String password, String userName) async{ 
    final user = await repository.signUp(email, password, userName);
    return user;
  }

  SignUpUseCase({required this.repository});
}

class LogOutUseCase{
  final AuthRepository repository;
  Future<void> call() async{
    await repository.logOut();
  }
  LogOutUseCase({required this.repository});
}

class GetCurrentUserUseCase{
  final AuthRepository repository;
  User? call(){
    return repository.getCurrentUser();
  }
  GetCurrentUserUseCase({required this.repository});
}