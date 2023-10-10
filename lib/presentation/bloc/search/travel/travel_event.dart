import 'package:equatable/equatable.dart';

class TravelEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetRestaurantInfoEvent extends TravelEvent {
  final int id;

  GetRestaurantInfoEvent({required this.id});
}

class GetAccommoInfoEvent extends TravelEvent {
  final int id;

  GetAccommoInfoEvent({required this.id});
}

class GetAttractionInfoEvent extends TravelEvent {
  final int id;

  GetAttractionInfoEvent({required this.id});
}

class GetMovieLocationInfoEvent extends TravelEvent {
  final int id;

  GetMovieLocationInfoEvent({required this.id});
}
