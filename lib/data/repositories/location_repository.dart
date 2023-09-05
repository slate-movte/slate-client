import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/location_repository.dart';
import '../sources/native/permission_native_data_source.dart';
import '../sources/remote/location_remote_data_source.dart';

class LocRepositoryImplementation implements LocationRepository {

  LocationRemoteDataSource locDataSource;
  PermissionNativeDataSource permissionDataSource;

  LocRepositoryImplementation({required this.locDataSource, required this.permissionDataSource});

  @override
  Future<Either<Failure, LatLng>> getLocation() async {
    try {

      final position;

      if(await permissionDataSource.getLocationPermissionStatus()){
        position = await locDataSource.getCurrentLocation();
      }else{
        position = LatLng(35.171585 , 129.127796);
      }

      return Right(position);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}