import 'package:dartz/dartz.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/core/usecases/usecase.dart';
import 'package:slate/domain/entities/accommo.dart';
import 'package:slate/domain/entities/attraction.dart';
import 'package:slate/domain/entities/movie.dart';
import 'package:slate/domain/entities/restaurant.dart';
import 'package:slate/domain/repositories/search_repository.dart';

abstract class SearchUseCase {
  SearchRepository repository;

  SearchUseCase({required this.repository});
}

class KeywordSearch extends SearchUseCase
    implements UseCase<List, (String, int, int)> {
  KeywordSearch({required super.repository});

  @override
  Future<Either<Failure, List>> call((String, int, int) params) async {
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

class AccommoInfoSearch extends SearchUseCase implements UseCase<Accommo, int> {
  AccommoInfoSearch({required super.repository});

  @override
  Future<Either<Failure, Accommo>> call(int params) async {
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
