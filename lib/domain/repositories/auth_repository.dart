import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, int>> checkKakaoOAuthState();
}
