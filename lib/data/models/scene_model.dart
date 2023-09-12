import 'package:slate/domain/entities/scene.dart';

class SceneModel extends Scene {
  SceneModel(Map<String, dynamic> json, int movieId, String title)
      : super(
          id: json['sceneId'],
          imageUrl: json['imageUrl'],
          movieId: movieId,
          title: title,
        );
}
