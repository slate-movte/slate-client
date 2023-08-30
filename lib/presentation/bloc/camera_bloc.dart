import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slate/core/errors/exceptions.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/core/usecases/usecase.dart';
import 'package:slate/domain/usecases/camera_usecase.dart';
import 'package:slate/presentation/bloc/camera_event.dart';
import 'package:slate/presentation/bloc/camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  GetCameraController getCameraController;
  TakePicture takePicture;

  CameraBloc({
    required this.getCameraController,
    required this.takePicture,
  }) : super(CameraGetReady()) {
    on<CameraOnEvent>(_cameraOnEvent);
    on<TakePictureEvent>(_takePictureEvent);
  }

  Future _cameraOnEvent(
    CameraOnEvent event,
    Emitter<CameraState> emit,
  ) async {
    emit(CameraGetReady());
    final result = await getCameraController(NoParams());
    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case CameraControlException:
            emit(CameraError(message: 'Camera Not Found'));
          case CameraNotFoundException:
            emit(CameraError(message: 'Camera Controller is not working'));
          default:
            emit(CameraError(message: 'Camera Error'));
        }
      },
      (result) {
        emit(CameraOn(controller: result));
      },
    );
  }

  Future _takePictureEvent(
    TakePictureEvent event,
    Emitter<CameraState> emit,
  ) async {
    emit(TakePictureOn());
    final result = await takePicture(event.controller);
    result.fold(
      (failure) {
        if (failure is CameraFailure) {
          emit(CameraError(message: 'Take Picture Error'));
        }
      },
      (result) {
        emit(TakePictureDone(image: result));
      },
    );
  }
}
