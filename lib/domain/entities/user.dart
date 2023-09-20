import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String? idToken;
  final String? nickname;
  final String? profileImageUrl;
  final String? accessToken;
  final String? refreshToken;

  const User({
    required this.id,
    this.idToken,
    this.nickname,
    this.profileImageUrl,
    this.accessToken,
    this.refreshToken,
  });

  @override
  List<Object?> get props => [id];
}
