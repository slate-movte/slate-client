import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class InitAuth extends AuthState {}

class SignUpDone extends AuthState {}

class SignInDone extends AuthState {}

class SignOutDone extends AuthState {}

class LoadingAuthState extends AuthState {}

class DoSignUp extends AuthState {}

class DoSignIn extends AuthState {}

class DoSignOut extends AuthState {}
