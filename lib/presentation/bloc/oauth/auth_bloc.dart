import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slate/domain/usecases/auth_usecase.dart';
import 'package:slate/presentation/bloc/oauth/auth_event.dart';
import 'package:slate/presentation/bloc/oauth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  SignUpWithKakaoOAuth2 signUpWithKakaoOAuth2;

  AuthBloc({
    required this.signUpWithKakaoOAuth2,
  }) : super(InitAuth()) {}

  // Future _SignUpWithKakaoEvent()
}
