// ignore_for_file: unused_import

import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/movie.dart';

abstract class SceneRepository {
  Future<Either<Failure, List<Movie>>> getScenesWithMovieTitle(String title);
}
