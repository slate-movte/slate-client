import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/utils/enums.dart';

class MapItem extends Equatable {
  final MarkerId markerId;
  final TravelType type;
  final String title;
  final LatLng position;

  const MapItem({
    required this.markerId,
    required this.type,
    required this.title,
    required this.position,
  });

  @override
  List<Object?> get props => [markerId];
}
