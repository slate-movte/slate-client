import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

class CameraEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CameraOnEvent extends CameraEvent {}

class CameraOffEvent extends CameraEvent {}

class TakePictureEvent extends CameraEvent {
  final CameraController controller;

  TakePictureEvent({required this.controller});

  @override
  List<Object?> get props => [controller];
}
