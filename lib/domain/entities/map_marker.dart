import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/utils/enums.dart';

class MapMarker extends Marker with EquatableMixin {
  final TravelType type;
  final String title;

  MapMarker({
    required super.markerId,
    required this.type,
    required this.title,
    required super.position,
  });

  @override
  List<Object?> get props => [markerId];
}
