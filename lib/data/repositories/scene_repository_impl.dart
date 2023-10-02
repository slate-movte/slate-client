import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:slate/core/errors/exceptions.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/data/sources/remote/scene_api_remote_data_source.dart';
import 'package:slate/domain/entities/movie.dart';
import 'package:slate/domain/repositories/scene_repository.dart';

class SceneRepositoryImpl implements SceneRepository {
  SceneApiRemoteDataSource dataSource;

  SceneRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Movie>>> getScenesWithMovieTitle(
    String title,
  ) async {
    try {
      final result = await dataSource.getScenesWithMovieTitle(title);
      return Right(result);
    } on ApiException {
      return Left(SceneFailure());
    } on HttpException {
      return Left(ServerFailure());
    }
  }
}
