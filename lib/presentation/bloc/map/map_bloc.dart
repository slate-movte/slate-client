import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/map_usecase.dart';
import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  GetCameraPosition getCameraPosition;
  GetMarkersWithType getMarkersWithType;

  MapBloc({
    required this.getCameraPosition,
    required this.getMarkersWithType,
  }) : super(MapLoading()) {
    on<InitializeMapEvent>(_initializeMap);
    on<Move2UserLocationEvent>(_move2UserLocation);
    on<GetMarkersEvent>(_getMarkers);
  }

  Future _initializeMap(
    InitializeMapEvent event,
    Emitter<MapState> emit,
  ) async {
    emit(MapLoading());
    final result = await getCameraPosition(event.latLng);
    result.fold(
      (failure) {
        emit(MapError());
      },
      (cameraPosition) {
        emit(MapInitialized(cameraPosition: cameraPosition));
      },
    );
  }

  Future _move2UserLocation(
    Move2UserLocationEvent event,
    Emitter<MapState> emit,
  ) async {
    emit(CameraMoving());
    final result = await getCameraPosition(null);
    result.fold(
      (failure) {
        emit(MapError());
      },
      (cameraPosition) {
        emit(CameraMoved(cameraPosition: cameraPosition));
      },
    );
  }

  Future _getMarkers(
    GetMarkersEvent event,
    Emitter<MapState> emit,
  ) async {
    emit(MarkerLoading());

    final position = await getCameraPosition(event.latLng);

    await position.fold(
      (failure) {
        emit(MapError());
      },
      (cameraPosition) async {
        emit(CameraMoved(cameraPosition: cameraPosition));
        final result = await getMarkersWithType((event.type, event.latLng));
        result.fold(
          (failure) {
            emit(const MarkerError(message: '와우'));
          },
          (markers) {
            emit(MarkerLoaded(markers: markers));
          },
        );
      },
    );
  }
}
