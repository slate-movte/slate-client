import 'package:dartz/dartz.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/data/sources/remote/search_api_remote_data_source.dart';

import 'package:slate/domain/entities/movie.dart';
import 'package:slate/domain/entities/travel.dart';

import 'package:slate/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  SearchApiRemoteDataSource dataSource;

  SearchRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Accommodation>> getAccommoInfo(int id) async {
    try {
      Accommodation result = await dataSource.getAccommoInfoWithId(id);
      return Right(result);
    } on Exception {
      return Left(SearchFailure());
    }
  }

  @override
  Future<Either<Failure, Attraction>> getAttractionInfo(int id) async {
    try {
      Attraction result = await dataSource.getAttractionInfoWithId(id);
      return Right(result);
    } on Exception {
      return Left(SearchFailure());
    }
  }

  @override
  Future<Either<Failure, List>> getKeywordSearchResults(
    String keyword,
    int movieLastId,
    int attractionLastId,
  ) async {
    try {
      List result = await dataSource.getSearchResultsWithKeyword(
        keyword,
        movieLastId,
        attractionLastId,
      );
      return Right(result);
    } on Exception {
      return Left(SearchFailure());
    }
  }

  @override
  Future<Either<Failure, Movie>> getMovieInfo(int id) async {
    try {
      Movie result = await dataSource.getMovieInfoWithId(id);
      return Right(result);
    } on Exception {
      return Left(SearchFailure());
    }
  }

  @override
  Future<Either<Failure, Restaurant>> getRestaurantInfo(int id) async {
    try {
      Restaurant result = await dataSource.getRestaurantInfoWithId(id);
      return Right(result);
    } on Exception {
      return Left(SearchFailure());
    }
  }
}
