import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/movie.dart';
import '../entities/travel.dart';
import '../repositories/search_repository.dart';

abstract class SearchUseCase {
  SearchRepository repository;

  SearchUseCase({required this.repository});
}

class KeywordSearch extends SearchUseCase
    implements UseCase<Map<String, List>, (String, int, int)> {
  KeywordSearch({required super.repository});

  @override
  Future<Either<Failure, Map<String, List>>> call(
    (String, int, int) params,
  ) async {
    return await super
        .repository
        .getKeywordSearchResults(params.$1, params.$2, params.$3);
  }
}

class MovieInfoSearch extends SearchUseCase implements UseCase<Movie, int> {
  MovieInfoSearch({required super.repository});

  @override
  Future<Either<Failure, Movie>> call(int params) async {
    return await super.repository.getMovieInfo(params);
  }
}

class RestaurantInfoSearch extends SearchUseCase
    implements UseCase<Restaurant, int> {
  RestaurantInfoSearch({required super.repository});

  @override
  Future<Either<Failure, Restaurant>> call(int params) async {
    return await super.repository.getRestaurantInfo(params);
  }
}

class AccommoInfoSearch extends SearchUseCase
    implements UseCase<Accommodation, int> {
  AccommoInfoSearch({required super.repository});

  @override
  Future<Either<Failure, Accommodation>> call(int params) async {
    return await super.repository.getAccommoInfo(params);
  }
}

class AttractionInfoSearch extends SearchUseCase
    implements UseCase<Attraction, int> {
  AttractionInfoSearch({required super.repository});

  @override
  Future<Either<Failure, Attraction>> call(int params) async {
    return await super.repository.getAttractionInfo(params);
  }
}

class MovieLocationInfoSearch extends SearchUseCase
    implements UseCase<MovieLocation, int> {
  MovieLocationInfoSearch({required super.repository});

  @override
  Future<Either<Failure, MovieLocation>> call(int params) async {
    return await super.repository.getMovieLocationInfo(params);
  }
}
