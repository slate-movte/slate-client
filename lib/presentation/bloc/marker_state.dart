import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MarkerState extends Equatable{
  const MarkerState();

  @override
  List<Object?> get props => [];
}

class MarkerLoadingState extends MarkerState {}

class MarkerLoadedState extends MarkerState {
  final Set<Marker> markerData;

  MarkerLoadedState({required this.markerData});

  @override
  List<Object?> get props => [markerData];
}

class MarkerErrorState extends MarkerState {
  final String message;

  MarkerErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}