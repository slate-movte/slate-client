import 'package:equatable/equatable.dart';

abstract class PermissionState extends Equatable{
  const PermissionState();

  @override
  List<Object?> get props => [];
}

class PermissionAcceptState extends PermissionState {}

class PermissionDenyState extends PermissionState {}

