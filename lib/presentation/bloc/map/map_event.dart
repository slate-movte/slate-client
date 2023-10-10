import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/utils/enums.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

class InitializeMapEvent extends MapEvent {
  final LatLng? latLng;

  const InitializeMapEvent({this.latLng});
}

class Move2UserLocationEvent extends MapEvent {}

class GetMarkersEvent extends MapEvent {
  final LatLng? latLng;
  final TravelType type;

  const GetMarkersEvent({required this.type, this.latLng});
}
