import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable{
  const LocationEvent();

  @override
  List<Object?> get props => [];

}

class LocationLoadedEvent extends LocationEvent {}

class UpdateLocationEvent extends LocationEvent {}