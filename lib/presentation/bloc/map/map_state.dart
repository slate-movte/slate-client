import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/entities/map_item.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

class MapLoading extends MapState {}

class MapInitialized extends MapState {
  final CameraPosition cameraPosition;

  const MapInitialized({required this.cameraPosition});
}

class CameraMoving extends MapState {}

class CameraMoved extends MapState {
  final CameraPosition cameraPosition;

  const CameraMoved({required this.cameraPosition});
}

class MapError extends MapState {}

class CameraMovingError extends MapState {}
//

class MarkerLoading extends MapState {}

class MarkerLoaded extends MapState {
  final List<MapItem> markers;

  const MarkerLoaded({required this.markers});

  @override
  List<Object?> get props => [markers];
}

class MarkerError extends MapState {
  final String message;

  const MarkerError({required this.message});

  @override
  List<Object?> get props => [message];
}
