import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/location_repository.dart';
import '../sources/remote/location_remote_data_source.dart';

class LocRepositoryImplementation implements LocationRepository {

  LocationRemoteDataSource locDataSource;

  LocRepositoryImplementation({required this.locDataSource});

  @override
  Future<Either<Failure, LatLng>> getLocation() async {
    try {

      final position;

      //위치 동의 확인
      if(await checkLocationPermissionStatus() == true){
        //동의한 경우, 현재 위치 가져오기
        position = await locDataSource.getCurrentLocation();
      }else{
        //재확인 후 재설정
        await changeLocationPermission();
        if(await checkLocationPermissionStatus() == true) {
          //재설정에 따라, 동의했다면 현재 위치 가져오기
          position = await locDataSource.getCurrentLocation();
        }else{
          //동의하지 않은 경우, 기본 위치 제공
          position = LatLng(35.171585 , 129.127796);
        }
      }
      return Right(position);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<bool> checkLocationPermissionStatus() async {
    try {
      switch (await Permission.location.status) {
        case PermissionStatus.granted:
        case PermissionStatus.limited:
        case PermissionStatus.provisional:
          return true;
        case PermissionStatus.restricted:
        case PermissionStatus.denied:
        case PermissionStatus.permanentlyDenied:
          return false;
      }
    } catch (e) {
      throw PermissionException();
    }
  }

  Future<void> changeLocationPermission() async {
    try {
      if (await checkLocationPermissionStatus() ||
          await Permission.location.status ==
              PermissionStatus.permanentlyDenied) {
        openAppSettings();
      } else {
        await Permission.location.request();
      }
    } catch (e) {
      throw CacheException();
    }
  }
}