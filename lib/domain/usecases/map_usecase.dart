import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../../core/utils/enums.dart';
import '../entities/map_item.dart';
import '../repositories/map_repository.dart';

abstract class MapUseCase {}

class GetMarkersWithType extends MapUseCase
    implements UseCase<List<MapItem>, (TravelType type, LatLng? latLng)> {
  MapRepository repository;

  GetMarkersWithType({required this.repository});

  @override
  Future<Either<Failure, List<MapItem>>> call(
    (TravelType, LatLng?) params,
  ) async {
    return await repository.getMarkersWithType(params.$1, params.$2);
  }
}

class GetCameraPosition extends MapUseCase
    implements UseCase<CameraPosition, LatLng?> {
  MapRepository repository;

  GetCameraPosition({required this.repository});

  @override
  Future<Either<Failure, CameraPosition>> call(LatLng? params) async {
    return await repository.getCameraPosition(params);
  }
}
