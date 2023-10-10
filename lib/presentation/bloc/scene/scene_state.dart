import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';

class SceneState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SceneLoading extends SceneState {}

class SceneIsEmpty extends SceneState {}

class SceneLoaded extends SceneState {
  final List<Movie> list;

  SceneLoaded({required this.list});

  @override
  List<Object?> get props => list;
}

class SceneInit extends SceneState {}

class SceneSelected extends SceneState {
  final String sceneUrl;

  SceneSelected({required this.sceneUrl});
}

class SceneError extends SceneState {}
