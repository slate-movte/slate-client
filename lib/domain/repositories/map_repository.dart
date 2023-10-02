import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/core/utils/enums.dart';
import 'package:slate/domain/entities/map_item.dart';

abstract class MapRepository {
  Future<Either<Failure, CameraPosition>> getCameraPosition(LatLng? latLng);
  Future<Either<Failure, List<MapItem>>> getMarkersWithType(
    TravelType type,
    LatLng? latLng,
  );
}
