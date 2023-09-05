import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/errors/failures.dart';

abstract class LocationRepository {

  Future<Either<Failure, LatLng>> getLocation();

}