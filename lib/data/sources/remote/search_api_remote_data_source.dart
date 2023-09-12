import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:slate/core/errors/exceptions.dart';
import 'package:slate/core/utils/apis.dart';
import 'package:slate/core/utils/enums.dart';

import 'package:slate/data/models/movie_model.dart';
import 'package:slate/data/models/travel_model.dart';
import 'package:slate/domain/entities/travel.dart';

abstract class SearchApiRemoteDataSource {
  Future<(List<MovieModel>, List<Travel>)> getSearchResultsWithKeyword(
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
  Future<(List<MovieModel>, List<Travel>)> getSearchResultsWithKeyword(
    String keyword,
    int movieLastId,
    int attractionLastId,
  ) async {
    List<MovieModel> movies = [];
    List<Travel> attractions = [];
    try {
      // var url = Uri.https(
      //   Api.hosts(),
      //   SearchAPI.keywordURL(
      //     keyword: keyword,
      //     movieLastId: movieLastId,
      //     attractionLastId: attractionLastId,
      //   ),
      // );

      var url = Uri.parse(
        SearchAPI.keywordURL(
          keyword: keyword,
          movieLastId: movieLastId,
          attractionLastId: attractionLastId,
        ),
      );

      // var url = Uri.parse(
      //   'https://dev.movte.cloud/search?keyword=&movieLastId=1&attractionLastId=1',
      // );

      var response = await http.get(url);
      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

        List jsonMovie =
            List<Map<String, dynamic>>.from(json['data']['movieList']);
        List jsonAttraction =
            List<Map<String, dynamic>>.from(json['data']['attractionList']);

        log('1');

        movies =
            jsonMovie.map((movie) => MovieModel.withKeywordApi(movie)).toList();
        log('2');

        attractions = jsonAttraction
            .map((attraction) => TravelModel.fromJson(attraction))
            .toList();
        log('3');

        return (movies, attractions);
      } else {
        throw HttpException(response.statusCode.toString());
      }
    } catch (e) {
      print(e);
      throw ApiException();
    }
  }
}
