import 'package:dartz/dartz.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/core/usecases/usecase.dart';

abstract class AuthUseCase {}

class SignInWithKakaoOAuth2 extends AuthUseCase
    implements UseCase<Void, NoParams> {
  @override
  Future<Either<Failure, Void>> call(NoParams params) {
    throw UnimplementedError();
  }
}

class SignUpWithKakaoOAuth2 {}

class SignOut {}
