import 'package:dartz/dartz.dart';
import 'package:slate/core/errors/failures.dart';

import 'package:slate/domain/entities/movie.dart';
import 'package:slate/domain/entities/travel.dart';

abstract class SearchRepository {
  Future<Either<Failure, Map<String, List>>> getKeywordSearchResults(
    String keyword,
    int movieLastId,
    int attractionLastId,
  );

  Future<Either<Failure, Movie>> getMovieInfo(int id);

  Future<Either<Failure, Restaurant>> getRestaurantInfo(int id);

  Future<Either<Failure, Accommodation>> getAccommoInfo(int id);

  Future<Either<Failure, Attraction>> getAttractionInfo(int id);

  Future<Either<Failure, MovieLocation>> getMovieLocationInfo(int id);
}
