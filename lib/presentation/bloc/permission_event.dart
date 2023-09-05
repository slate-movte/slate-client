import 'package:equatable/equatable.dart';

abstract class PermissionEvent extends Equatable{
  const PermissionEvent();

  @override
  List<Object?> get props => [];

}

class PermissionGetEvent extends PermissionEvent {}

class PermissionSetEvent extends PermissionEvent {}

