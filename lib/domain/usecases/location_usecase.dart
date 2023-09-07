import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/location_repository.dart';

abstract class LocationUseCase {}

class GetLocation extends LocationUseCase implements UseCase<LatLng, NoParams> {
  LocationRepository repository;

  GetLocation({required this.repository});

  @override
  Future<Either<Failure, LatLng>> call(NoParams params) async {
    return await repository.getLocation();
  }
}
