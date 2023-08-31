import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

class CameraState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CameraGetReady extends CameraState {}

class CameraOn extends CameraState {
  final CameraController controller;

  CameraOn({required this.controller});

  @override
  List<Object?> get props => [controller];
}

class CameraError extends CameraState {
  final String message;

  CameraError({required this.message});

  @override
  List<Object?> get props => [message];
}

class TakePictureOn extends CameraState {}

class TakePictureDone extends CameraState {
  final XFile image;

  TakePictureDone({required this.image});

  @override
  List<Object?> get props => [image];
}
