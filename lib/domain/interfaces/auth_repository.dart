import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> logIn(String email, String password);
  Future<User?> signUp(String email, String password, String userName);
  Future<void> logOut();
  User? getCurrentUser();
}