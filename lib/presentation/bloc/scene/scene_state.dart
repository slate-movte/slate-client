import 'package:equatable/equatable.dart';
import 'package:slate/domain/entities/movie.dart';

class SceneState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SceneLoading extends SceneState {}

class SceneLoaded extends SceneState {
  List<Movie> list;

  SceneLoaded({required this.list});

  @override
  // TODO: implement props
  List<Object?> get props => list;
}

class SceneInit extends SceneState {}

class SceneSelected extends SceneState {
  String sceneUrl;

  SceneSelected({required this.sceneUrl});
}

class SceneError extends SceneState {}
