import 'dart:developer';

import 'package:slate/data/models/scene_model.dart';
import 'package:slate/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    super.posterUrl,
    super.openDate,
    super.audienceCount,
    super.company,
    super.director,
    super.movieCastList,
    super.plot,
    super.rating,
    super.sceneImages,
  });

  factory MovieModel.withScenes(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int,
      title: json['title'] as String,
      sceneImages: List<Map<String, dynamic>>.from(json['scenes'])
          .map(
            (data) => SceneModel.fromJson(
              data,
              json['title'],
              json['id'],
            ),
          )
          .toList(),
    );
  }

  factory MovieModel.withKeywordApi(Map<String, dynamic> json) {
    return MovieModel(
      id: json['movieId'] as int,
      title: json['title'] as String,
      posterUrl: json['posterUrl'] as String,
      openDate: DateTime.parse(json['openDate'] as String),
      movieCastList: List<String>.from(json['movieCastList']),
    );
  }

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    log('ddd');
    return MovieModel(
      id: json['id'],
      title: json['title'],
      posterUrl: json['posterUrl'],
      openDate: DateTime.parse(json['openDate']),
      movieCastList: List<String>.from(json['movieCastList']),
      director: json['director'],
      company: json['company'],
      rating: json['rating'],
      audienceCount: json['audienceCount'],
      plot: json['plot'],
      sceneImages: List<Map<String, dynamic>>.from(json['sceneImages'])
          .map(
            (data) => SceneModel.fromJson(
              data,
              json['title'],
              json['id'],
            ),
          )
          .toList(),
    );
  }
}
