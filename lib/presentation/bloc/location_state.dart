import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationState extends Equatable{
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationLoadingState extends LocationState {}

class LocationLoadedState extends LocationState {
  final LatLng locationData;

  LocationLoadedState({required this.locationData});

  @override
  List<Object?> get props => [locationData];
}

class LocationErrorState extends LocationState {
  final String message;

  LocationErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}