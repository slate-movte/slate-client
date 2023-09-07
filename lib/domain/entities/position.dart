import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Position extends Equatable {
  final String address;
  final LatLng latLng;

  const Position({
    required this.address,
    required this.latLng,
  });

  @override
  List<Object?> get props => [latLng.latitude, latLng.longitude];
}
