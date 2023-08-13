import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:slate/core/errors/failures.dart';

abstract class CameraRepository {
  Future<Either<Failure, CameraController>>
      getCameraControllerWithInitialized();
}
