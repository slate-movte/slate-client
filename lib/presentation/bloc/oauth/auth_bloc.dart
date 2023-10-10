import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/auth_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  SignUpWithKakaoOAuth2 signUpWithKakaoOAuth2;

  AuthBloc({
    required this.signUpWithKakaoOAuth2,
  }) : super(InitAuth());
}
