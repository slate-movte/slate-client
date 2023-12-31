import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/movie.dart';
import '../repositories/scene_repository.dart';

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
