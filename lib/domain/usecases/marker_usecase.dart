import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/marker_repository.dart';

abstract class MarkerUseCase {}

abstract class GetMarker extends MarkerUseCase
    implements UseCase<Set<Marker>, String> {}


class GetMarkerInfo implements GetMarker {

  MarkerRepository repository;

  GetMarkerInfo({required this.repository});

  @override
  Future<Either<Failure, Set<Marker>>> call(String params) async {
    return await repository.getMarkerLists(params);
  }
}
