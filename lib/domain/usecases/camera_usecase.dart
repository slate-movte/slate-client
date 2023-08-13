import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/core/usecases/usecase.dart';
import 'package:slate/domain/repositories/camera_repository.dart';

abstract class CameraUseCase {}

class GetCameraController extends CameraUseCase
    implements UseCase<CameraController, NoParams> {
  CameraRepository repository;

  GetCameraController({required this.repository});

  @override
  Future<Either<Failure, CameraController>> call(NoParams params) async {
    return await repository.getCameraControllerWithInitialized();
  }
}
