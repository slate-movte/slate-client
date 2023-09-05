import 'package:dartz/dartz.dart';
import '../../core/usecases/usecase.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/permission_repository.dart';
import '../sources/native/permission_native_data_source.dart';

class PermissionRepositoryImplementation implements PermissionRepository {
  PermissionNativeDataSource permissionDataSource;

  PermissionRepositoryImplementation({required this.permissionDataSource});

  @override
  Future<Either<Failure, bool>> getLocationPermission() async {
    try {
      final status = await permissionDataSource.getLocationPermissionStatus();
      return Right(status);
    } on PermissionException {
      return Left(PermissionFailure());
    }
  }

  @override
  Future<Either<Failure, Void>> setLocationPermission() async {
    try {
      await permissionDataSource.setLocationPermission();
      return Right(Void());
    } on CacheException {
      return Left(PermissionFailure());
    }
  }


}