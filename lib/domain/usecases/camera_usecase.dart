import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/camera_repository.dart';

abstract class CameraUseCase {}

class GetCameraController extends CameraUseCase
    implements UseCase<CameraController, NoParams> {
  CameraRepository repository;

  GetCameraController({required this.repository});

  @override
  Future<Either<Failure, CameraController>> call(NoParams params) async {
    return await repository.getCameraController();
  }
}

class ChangeCameraDirection extends CameraUseCase
    implements UseCase<CameraController, NoParams> {
  CameraRepository repository;

  ChangeCameraDirection({required this.repository});

  @override
  Future<Either<Failure, CameraController>> call(NoParams params) async {
    return await repository.getCameraController(changeDirection: true);
  }
}

class TakePicture extends CameraUseCase
    implements UseCase<XFile, CameraController> {
  CameraRepository repository;

  TakePicture({required this.repository});

  @override
  Future<Either<Failure, XFile>> call(CameraController params) async {
    return await repository.getPictureImage(params);
  }
}

class SavePicture extends CameraUseCase implements UseCase<Void, XFile> {
  CameraRepository repository;

  SavePicture({required this.repository});

  @override
  Future<Either<Failure, Void>> call(XFile params) async {
    return await repository.savePicture2Gallery(params);
  }
}

class DisposeCamera extends CameraUseCase implements UseCase<Void, NoParams> {
  CameraRepository repository;

  DisposeCamera({required this.repository});

  @override
  Future<Either<Failure, Void>> call(NoParams params) async {
    return await repository.disposeCamera();
  }
}
