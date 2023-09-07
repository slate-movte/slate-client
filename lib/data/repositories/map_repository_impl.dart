import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/errors/exceptions.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/core/utils/enums.dart';
import 'package:slate/data/sources/remote/location_remote_data_source.dart';
import 'package:slate/data/sources/remote/map_remote_data_source.dart';
import 'package:slate/domain/entities/map_marker.dart';
import 'package:slate/domain/repositories/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  LocationRemoteDataSource locationRemoteDataSource;
  MapRemoteDataSource mapRemoteDataSource;

  MapRepositoryImpl({
    required this.locationRemoteDataSource,
    required this.mapRemoteDataSource,
  });

  @override
  Future<Either<Failure, CameraPosition>> getCameraPosition(
    LatLng? latLng,
  ) async {
    try {
      latLng ??= await locationRemoteDataSource.getCurrentLocation();
      final cameraPosition =
          await mapRemoteDataSource.getCameraPosition(latLng);
      return Right(cameraPosition);
    } on MapException {
      return Left(MapFailure());
    }
  }

  @override
  Future<Either<Failure, Set<MapMarker>>> getMarkersWithType(
    TravelType type,
    LatLng? latLng,
  ) async {
    try {
      latLng ??= await locationRemoteDataSource.getCurrentLocation();
      final markers =
          await mapRemoteDataSource.getMarkersWithMapAPI(latLng, type);
      return Right(markers);
    } on MapException {
      return Left(MapFailure());
    }
  }
}
