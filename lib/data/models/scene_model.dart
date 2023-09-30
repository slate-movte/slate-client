import 'dart:developer';

import 'package:slate/domain/entities/scene.dart';

class SceneModel extends Scene {
  SceneModel({
    required super.movieId,
    required super.title,
    required super.id,
    required super.imageUrl,
  });

  factory SceneModel.fromJson(
      Map<String, dynamic> json, int movieId, String title) {
    log('message');
    return SceneModel(
      movieId: movieId,
      title: title,
      id: json['sceneId'],
      imageUrl: json['imageUrl'],
    );
  }

  // SceneModel(Map<String, dynamic> json, int movieId, String title)
  //     : super(
  //         id: json['sceneId'],
  //         imageUrl: json['imageUrl'],
  //         movieId: movieId,
  //         title: title,
  //       );
}
