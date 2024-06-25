import 'package:crypto_track/domain/interfaces/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository{
  final _auth = FirebaseAuth.instance;
  @override
  Future<User?> logIn(String email, String password) async{
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw('Wrong password provided for that user.');
      }
    }
    return null;
    
  }

  @override
  Future<void> logOut() async{
    try {
      await _auth.signOut();
    } catch (e) {
      throw(Exception(e));
    }
  }

  @override
  Future<User?> signUp(String email, String password, String userName) async{
    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw('The account already exists for that email.');
      }
    }catch (e){
      rethrow;
    }
    return null;
  }

  @override
  User? getCurrentUser(){
    final user = _auth.currentUser;
    return user;
  }

}