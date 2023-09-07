import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/core/utils/enums.dart';
import 'package:slate/domain/entities/map_marker.dart';

abstract class MapRepository {
  Future<Either<Failure, CameraPosition>> getCameraPosition(LatLng? latLng);
  Future<Either<Failure, Set<MapMarker>>> getMarkersWithType(
    TravelType type,
    LatLng? latLng,
  );
}
