import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CameraEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CameraOnEvent extends CameraEvent {}

class DirectionChangeEvent extends CameraEvent {}

class CameraOffEvent extends CameraEvent {}

class TakePictureEvent extends CameraEvent {
  final CameraController controller;

  TakePictureEvent({required this.controller});

  @override
  List<Object?> get props => [controller];
}

class SavePictureEvent extends CameraEvent {
  final XFile image;

  SavePictureEvent({required this.image});

  @override
  List<Object?> get props => [image];
}

class DisposeEvent extends CameraEvent {
  final BuildContext context;

  DisposeEvent({required this.context});
}
