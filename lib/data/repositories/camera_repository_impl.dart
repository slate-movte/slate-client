import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/repositories/camera_repository.dart';
import '../sources/native/camera_native_data_source.dart';

class CameraRepositoryImpl implements CameraRepository {
  CameraNativeDataSource cameraDataSource;

  CameraRepositoryImpl({required this.cameraDataSource});

  @override
  Future<Either<Failure, CameraController>> getCameraController({
    bool changeDirection = false,
  }) async {
    try {
      CameraController controller =
          await cameraDataSource.getCameraControllerWithInitialized(
        changeDirection,
      );
      return Right(controller);
    } on CameraNotFoundException {
      return Left(CameraFailure());
    } on CameraControlException {
      return Left(CameraFailure());
    }
  }

  @override
  Future<Either<Failure, XFile>> getPictureImage(
    CameraController controller,
  ) async {
    try {
      XFile image = await cameraDataSource.getImageAfterTakePicture(controller);
      return Right(image);
    } on TakePictureException {
      return Left(CameraFailure());
    }
  }

  @override
  Future<Either<Failure, Void>> savePicture2Gallery(XFile image) async {
    try {
      await cameraDataSource.saveXFileImage2LocalGallery(image);
      return Right(Void());
    } on SavePictureException {
      return Left(CameraFailure());
    }
  }

  @override
  Future<Either<Failure, Void>> disposeCamera() async {
    try {
      await cameraDataSource.disposeCamera();
      return Right(Void());
    } on CameraControlException {
      return Left(CameraFailure());
    }
  }
}
