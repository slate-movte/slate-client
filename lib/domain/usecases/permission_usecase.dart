import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/permission_repository.dart';

abstract class PermissionUseCase {}

abstract class GetPermission extends PermissionUseCase
    implements UseCase<bool, NoParams> {}

class GetLocationPermission implements GetPermission {
  PermissionRepository repository;
  GetLocationPermission({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.getLocationPermission();
  }
}

abstract class SetPermission extends PermissionUseCase
    implements UseCase<Void, NoParams> {}

class SetLocationPermission implements SetPermission {

  PermissionRepository repository;

  SetLocationPermission({required this.repository});

  @override
  Future<Either<Failure, Void>> call(NoParams params) async {
    return await repository.setLocationPermission();
  }
}

