import 'package:slate/data/models/movie_model.dart';
import 'package:slate/data/models/travel_model.dart';

abstract class SearchApiRemoteDataSource {
  Future<List> getSearchResultsWithKeyword(
    String keyword,
    int movieLastId,
    int attractionLastId,
  );
  Future<MovieModel> getMovieInfoWithId(int id);
  Future<RestaurantModel> getRestaurantInfoWithId(int id);
  Future<AttractionModel> getAttractionInfoWithId(int id);
  Future<AccommodationModel> getAccommoInfoWithId(int id);
}

class SearchApiRemoteDataSourceImpl implements SearchApiRemoteDataSource {
  @override
  Future<AccommodationModel> getAccommoInfoWithId(int id) {
    throw UnimplementedError();
  }

  @override
  Future<AttractionModel> getAttractionInfoWithId(int id) {
    throw UnimplementedError();
  }

  @override
  Future<MovieModel> getMovieInfoWithId(int id) {
    throw UnimplementedError();
  }

  @override
  Future<RestaurantModel> getRestaurantInfoWithId(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List> getSearchResultsWithKeyword(
    String keyword,
    int movieLastId,
    int attractionLastId,
  ) {
    throw UnimplementedError();
  }
}