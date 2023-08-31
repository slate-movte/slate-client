import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/core/usecases/usecase.dart';
import 'package:slate/domain/usecases/camera_usecase.dart';
import 'package:slate/presentation/bloc/camera/camera_event.dart';
import 'package:slate/presentation/bloc/camera/camera_state.dart';

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
        emit(CameraError(message: '다시 시도해주세요.'));
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
