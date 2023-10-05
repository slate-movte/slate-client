import 'package:slate/domain/entities/scene.dart';

class SceneModel extends Scene {
  SceneModel({
    required super.movieId,
    required super.title,
    required super.id,
    required super.imageUrl,
  });

  factory SceneModel.fromJson(
    Map<String, dynamic> json,
    String title,
    int movieId,
  ) {
    return SceneModel(
      movieId: movieId,
      title: title,
      id: json['sceneId'],
      imageUrl: json['imageUrl'],
    );
  }
}
