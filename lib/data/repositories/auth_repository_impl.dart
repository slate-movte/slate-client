import 'package:dartz/dartz.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/data/sources/native/auth_native_data_source.dart';
import 'package:slate/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthNativeDateSource authNativeDateSource;

  AuthRepositoryImpl({required this.authNativeDateSource});

  @override
  Future<Either<Failure, int>> checkKakaoOAuthState() async {
    try {
      int id = await authNativeDateSource.getKakaoUserId();
      return Right(id);
    } on KakaoException {
      return Left(AuthFailure());
    }
  }
}
