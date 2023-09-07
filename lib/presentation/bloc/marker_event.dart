import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

abstract class MarkerEvent extends Equatable{
  const MarkerEvent();

  @override
  List<Object?> get props => [];

}

class MarkerLoadedEvent extends MarkerEvent {
  String markerType;

  MarkerLoadedEvent({required this.markerType});

}

class GetMovieMarkerLoadedEvent extends MarkerEvent {}
