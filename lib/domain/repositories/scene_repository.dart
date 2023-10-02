import 'package:dartz/dartz.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/domain/entities/movie.dart';
import 'package:slate/domain/entities/scene.dart';

abstract class SceneRepository {
  Future<Either<Failure, List<Movie>>> getScenesWithMovieTitle(String title);
}
