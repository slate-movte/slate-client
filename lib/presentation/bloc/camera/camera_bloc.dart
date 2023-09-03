import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/core/usecases/usecase.dart';
import 'package:slate/domain/usecases/camera_usecase.dart';
import 'package:slate/presentation/bloc/camera/camera_event.dart';
import 'package:slate/presentation/bloc/camera/camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  GetCameraController getCameraController;
  ChangeCameraDirection changeCameraDirection;
  TakePicture takePicture;
  SavePicture savePicture;

  CameraBloc({
    required this.getCameraController,
    required this.changeCameraDirection,
    required this.takePicture,
    required this.savePicture,
  }) : super(CameraGetReady()) {
    on<CameraOnEvent>(_cameraOnEvent);
    on<DirectionChangeEvent>(_directionChangeEvent);
    on<TakePictureEvent>(_takePictureEvent);
    on<SavePictureEvent>(_savePictureEvent);
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

  Future _directionChangeEvent(
    DirectionChangeEvent event,
    Emitter<CameraState> emit,
  ) async {
    final result = await changeCameraDirection(NoParams());
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

  Future _savePictureEvent(
    SavePictureEvent event,
    Emitter<CameraState> emit,
  ) async {
    emit(SavePictureOn());
    final result = await savePicture(event.image);
    result.fold((failure) {
      if (failure is CameraFailure) {
        emit(CameraError(message: 'Save Picture Error'));
      }
    }, (success) {
      emit(SavePictureDone());
    });
  }
}
