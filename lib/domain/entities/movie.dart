import 'package:equatable/equatable.dart';

import 'scene.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String? director;
  final String? company;
  final DateTime? openDate;
  final String? rating;
  final String? posterUrl;
  final String? audienceCount;
  final String? plot;
  final List<String> movieCastList;
  final List<Scene> sceneImages;

  const Movie({
    required this.id,
    required this.title,
    this.posterUrl,
    this.openDate,
    this.movieCastList = const [],
    this.sceneImages = const [],
    this.audienceCount,
    this.company,
    this.director,
    this.plot,
    this.rating,
  });

  @override
  List<Object?> get props => [id];

  @override
  String toString() {
    return 'id:$id, title:$title';
  }
}
