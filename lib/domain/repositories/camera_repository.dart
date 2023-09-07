import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/core/usecases/usecase.dart';

abstract class CameraRepository {
  Future<Either<Failure, CameraController>> getCameraController({
    bool changeDirection = false,
  });

  Future<Either<Failure, XFile>> getPictureImage(CameraController controller);

  Future<Either<Failure, Void>> savePicture2Gallery(XFile image);
}
