import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slate/domain/usecases/scene_usecase.dart';
import 'package:slate/presentation/bloc/scene/scene_event.dart';
import 'package:slate/presentation/bloc/scene/scene_state.dart';

class SceneBloc extends Bloc<SceneEvent, SceneState> {
  GetScenesWithMovieTitle getScenesWithMovieTitle;

  SceneBloc({
    required this.getScenesWithMovieTitle,
  }) : super(SceneInit()) {
    on<GetScenesEvent>(_getScenesEvent);
    on<RefreshEvent>(_refreshEvent);
    on<SelectedSceneEvent>(_selectedSceneEvent);
  }

  Future _refreshEvent(
    RefreshEvent event,
    Emitter<SceneState> emit,
  ) async {
    emit(SceneInit());
  }

  Future _selectedSceneEvent(
    SelectedSceneEvent event,
    Emitter<SceneState> emit,
  ) async {
    emit(SceneSelected(
      sceneUrl: event.sceneUrl,
    ));
  }

  Future _getScenesEvent(
    GetScenesEvent event,
    Emitter<SceneState> emit,
  ) async {
    emit(SceneLoading());

    final result = await getScenesWithMovieTitle(event.input);
    result.fold(
      (fail) {
        emit(SceneError());
      },
      (result) {
        emit(SceneLoaded(list: result));
      },
    );
  }
}
