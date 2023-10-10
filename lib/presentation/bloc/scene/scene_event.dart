import 'package:equatable/equatable.dart';

class SceneEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetScenesEvent extends SceneEvent {
  final String input;

  GetScenesEvent({required this.input});
}

class RefreshEvent extends SceneEvent {}

class SelectedSceneEvent extends SceneEvent {
  final String sceneUrl;

  SelectedSceneEvent({required this.sceneUrl});
}
