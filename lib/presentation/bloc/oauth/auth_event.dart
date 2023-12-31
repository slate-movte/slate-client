import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CheckOAuthEvent extends AuthEvent {}

class SignUpWithKakaoEvent extends AuthEvent {}

class SignInWithKakaoEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}
