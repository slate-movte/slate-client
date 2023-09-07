import 'package:dartz/dartz.dart';
import 'package:slate/core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, int>> checkKakaoOAuthState();
}
