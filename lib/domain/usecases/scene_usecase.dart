import 'package:dartz/dartz.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/core/usecases/usecase.dart';
import 'package:slate/domain/entities/movie.dart';
import 'package:slate/domain/repositories/scene_repository.dart';

abstract class SceneUseCase {}

class GetScenesWithMovieTitle extends SceneUseCase
    implements UseCase<List<Movie>, String> {
  SceneRepository repository;

  GetScenesWithMovieTitle({required this.repository});

  @override
  Future<Either<Failure, List<Movie>>> call(String params) async {
    return await repository.getScenesWithMovieTitle(params);
  }
}
