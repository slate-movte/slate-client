import 'package:equatable/equatable.dart';

import '../../../../domain/entities/travel.dart';

class TravelState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TravelDataLoading extends TravelState {}

class RestaurantDataLoaded extends TravelState {
  final Restaurant restaurant;

  RestaurantDataLoaded({required this.restaurant});

  @override
  List<Object?> get props => [restaurant];
}

class AccommoDataLoaded extends TravelState {
  final Accommodation accommodation;

  AccommoDataLoaded({required this.accommodation});

  @override
  List<Object?> get props => [accommodation];
}

class AttractionDataLoaded extends TravelState {
  final Attraction attraction;

  AttractionDataLoaded({required this.attraction});

  @override
  List<Object?> get props => [attraction];
}

class MovieLocationDataLoaded extends TravelState {
  final MovieLocation movieLocation;

  MovieLocationDataLoaded({required this.movieLocation});

  @override
  List<Object?> get props => [movieLocation];
}

class SearchError extends TravelState {
  final String message;

  SearchError({required this.message});

  @override
  List<Object?> get props => [message];
}
