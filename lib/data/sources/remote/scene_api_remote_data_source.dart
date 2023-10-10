import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../core/errors/exceptions.dart';
import '../../../core/utils/apis.dart';
import '../../models/movie_model.dart';

abstract class SceneApiRemoteDataSource {
  Future<List<MovieModel>> getScenesWithMovieTitle(String title);
}

class SceneApiRemoteDataSourceImpl implements SceneApiRemoteDataSource {
  @override
  Future<List<MovieModel>> getScenesWithMovieTitle(String title) async {
    try {
      var url = Uri.parse(SceneApi.scenesURL(title: title));

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

        return List<Map<String, dynamic>>.from(json['data']['movies'])
            .map((movie) => MovieModel.withScenes(movie))
            .toList();
      } else {
        throw HttpException(response.statusCode.toString());
      }
    } catch (e) {
      throw ApiException();
    }
  }
}
