import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:google_maps_flutter_platform_interface/src/types/marker.dart';

import 'package:slate/core/errors/failures.dart';

import '../../core/errors/exceptions.dart';
import '../../domain/repositories/marker_repository.dart';
import '../sources/remote/location_remote_data_source.dart';
import '../sources/remote/marker_remote_data_source.dart';

class MarkerRepositoryImplementation extends MarkerRepository{

  MarkerRemoteDataSource markerDataSource;
  LocationRemoteDataSource locationRemoteDataSource;

  MarkerRepositoryImplementation({required this.markerDataSource, required this.locationRemoteDataSource});

  @override
  Future<Either<Failure, Set<Marker>>> getMarkerLists(String movieType) async {
    try {

      LatLng curLocation = await locationRemoteDataSource.getCurrentLocation();
      final markers = await markerDataSource.getMarkerLists(curLocation, movieType);

      return Right(markers);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}