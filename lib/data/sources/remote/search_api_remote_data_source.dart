import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:slate/core/errors/exceptions.dart';
import 'package:slate/core/utils/apis.dart';

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
  Future<MovieLocationModel> getMovieLocationInfoWithId(int id);
}

class SearchApiRemoteDataSourceImpl implements SearchApiRemoteDataSource {
  @override
  Future<AccommodationModel> getAccommoInfoWithId(int id) async {
    try {
      var url = Uri.parse(SearchAPI.accommodationInfoURL(id: id));

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

        return AccommodationModel.fromJson(
          Map<String, dynamic>.from(json['data']),
        );
      } else {
        throw HttpException(response.statusCode.toString());
      }
    } catch (e) {
      throw ApiException();
    }
  }

  @override
  Future<AttractionModel> getAttractionInfoWithId(int id) async {
    try {
      var url = Uri.parse(SearchAPI.attractionInfoURL(id: id));

      var response = await http.get(url);
      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

        return AttractionModel.fromJson(
          Map<String, dynamic>.from(json['data']),
        );
      } else {
        throw HttpException(response.statusCode.toString());
      }
    } catch (e) {
      throw ApiException();
    }
  }

  @override
  Future<MovieModel> getMovieInfoWithId(int id) async {
    try {
      var url = Uri.parse(SearchAPI.movieInfoURL(id: id));

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

        return MovieModel.fromJson(
          Map<String, dynamic>.from(json['data']),
        );
      } else {
        throw HttpException(response.statusCode.toString());
      }
    } catch (e) {
      throw ApiException();
    }
  }

  @override
  Future<RestaurantModel> getRestaurantInfoWithId(int id) async {
    try {
      var url = Uri.parse(SearchAPI.restaurantInfoURL(id: id));

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

        return RestaurantModel.fromJson(
          Map<String, dynamic>.from(json['data']),
        );
      } else {
        throw HttpException(response.statusCode.toString());
      }
    } catch (e) {
      throw ApiException();
    }
  }

  @override
  Future<List> getSearchResultsWithKeyword(
    String keyword,
    int movieLastId,
    int attractionLastId,
  ) async {
    List results = [];
    try {
      var url = Uri.parse(
        SearchAPI.keywordURL(
          keyword: keyword,
          movieLastId: movieLastId,
          attractionLastId: attractionLastId,
        ),
      );

      var response = await http.get(url);
      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

        List jsonMovie =
            List<Map<String, dynamic>>.from(json['data']['movieList']);
        List jsonAttraction =
            List<Map<String, dynamic>>.from(json['data']['attractionList']);

        results.addAll(
          jsonMovie.map((movie) => MovieModel.withKeywordApi(movie)).toList(),
        );

        results.addAll(
          jsonAttraction
              .map((attraction) => TravelModel.fromJson(attraction))
              .toList(),
        );
        return results;
      } else {
        throw HttpException(response.statusCode.toString());
      }
    } catch (e) {
      throw ApiException();
    }
  }

  @override
  Future<MovieLocationModel> getMovieLocationInfoWithId(int id) async {
    try {
      var url = Uri.parse(SearchAPI.movieLocationInfoURL(id: id));

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

        return MovieLocationModel.fromJson(
          Map<String, dynamic>.from(json['data']),
        );
      } else {
        print("맵오류1");
        throw HttpException(response.statusCode.toString());
      }
    } catch (e) {
      print("맵오류2");
      throw ApiException();
    }
  }
}
