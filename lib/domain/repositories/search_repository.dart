import 'package:dartz/dartz.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/domain/entities/accommo.dart';
import 'package:slate/domain/entities/attraction.dart';
import 'package:slate/domain/entities/movie.dart';
import 'package:slate/domain/entities/restaurant.dart';

abstract class SearchRepository {
  Future<Either<Failure, List>> getKeywordSearchResults(
    String keyword,
    int movieLastId,
    int attractionLastId,
  );

  Future<Either<Failure, Movie>> getMovieInfo(int id);

  Future<Either<Failure, Restaurant>> getRestaurantInfo(int id);

  Future<Either<Failure, Accommo>> getAccommoInfo(int id);

  Future<Either<Failure, Attraction>> getAttractionInfo(int id);
}
