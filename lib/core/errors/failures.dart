import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class CameraFailure extends Failure {}

class ServerFailure extends Failure {}

class PermissionFailure extends Failure {}

class SearchFailure extends Failure {}

class AuthFailure extends Failure {}

class MapFailure extends Failure {}

class SceneFailure extends Failure {}

class CourseFailure extends Failure {}
