import 'package:slate/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required accessToken});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      accessToken: json['accessToken'],
    );
  }
}
