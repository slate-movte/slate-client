import 'package:slate/domain/entities/map_marker.dart';

class MapMarkerModel extends MapMarker {
  MapMarkerModel({
    required super.markerId,
    required super.type,
    required super.title,
    required super.position,
  });
}
