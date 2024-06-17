import 'package:crypto_track/domain/entities/user_entitie.dart';

class UserModel extends User {
  UserModel({required super.id, required super.email, required super.userName});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], email: json['email'], userName: json['id']);
  }
}