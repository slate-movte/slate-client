import 'package:slate/domain/entities/movie.dart';

class MovieModel extends Movie {
  // MovieModel.withKeywordApi({
  //   required super.id,
  //   required super.title,
  //   required super.posterUrl,
  //   required super.openDate,
  //   required super.movieCastList,
  // });

  // : super(
  //     id: json['movieId'] as int,
  //     title: json['title'] as String,
  //     posterUrl: json['posterUrl'] as String,
  //     openDate: DateTime.parse(json['openDate'] as String),
  //     movieCastList: json['movieCastList'] as List<String>,
  //   );

  MovieModel({
    required super.id,
    required super.title,
    required super.posterUrl,
    required super.openDate,
    super.audienceCount,
    super.company,
    super.director,
    super.movieCastList,
    super.plot,
    super.rating,
    super.sceneImages,
  });

  factory MovieModel.withKeywordApi(Map<String, dynamic> json) {
    return MovieModel(
      id: json['movieId'] as int,
      title: json['title'] as String,
      posterUrl: json['posterUrl'] as String,
      openDate: DateTime.parse(json['openDate'] as String),
      movieCastList: List<String>.from(json['movieCastList']),
    );
  }

  // : super(
  //     id: json['movieId'] as int,
  //     title: json['title'] as String,
  //     posterUrl: json['posterUrl'] as String,
  //     openDate: DateTime.parse(json['openDate'] as String),
  //     movieCastList: json['movieCastList'] as List<String>,
  //     director: json['director'] as String,
  //     company: json['company'] as String,
  //     rating: json['rating'] as String,
  //     audienceCount: json['audienceCount'] as String,
  //     plot: json['plot'] as String,
  //     sceneImages: (json['sceneImages'] as List<Map<String, dynamic>>)
  //         .map((data) => SceneModel(
  //               data,
  //               json['movieId'] as int,
  //               json['title'] as String,
  //             ))
  //         .toList(),
  //   );
}
