import '../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';

abstract class PermissionRepository {
  Future<Either<Failure, bool>> getLocationPermission();

  Future<Either<Failure, Void>> setLocationPermission();
}