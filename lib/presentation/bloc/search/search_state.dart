import 'package:equatable/equatable.dart';
import 'package:slate/domain/entities/accommodation.dart';
import 'package:slate/domain/entities/attraction.dart';
import 'package:slate/domain/entities/movie.dart';
import 'package:slate/domain/entities/restaurant.dart';

class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

// class KeywordDataLoading extends SearchState {}

// class MovieDataLoading extends SearchState {}

// class RestaurantDataLoading extends SearchState {}

// class AccommoDataLoading extends SearchState {}

// class AttractionDataLoading extends SearchState {}

// class KeywordDataLoaded extends SearchState {}

class InitSearch extends SearchState {}

class DataLoading extends SearchState {}

class KeywordDataLoaded extends SearchState {
  final List dataList;

  KeywordDataLoaded({required this.dataList});

  @override
  List<Object?> get props => dataList;
}

class MovieDataLoaded extends SearchState {
  final Movie movie;

  MovieDataLoaded({required this.movie});

  @override
  List<Object?> get props => [movie];
}

class RestaurantDataLoaded extends SearchState {
  final Restaurant restaurant;

  RestaurantDataLoaded({required this.restaurant});

  @override
  List<Object?> get props => [restaurant];
}

class AccommoDataLoaded extends SearchState {
  final Accommodation accommodation;

  AccommoDataLoaded({required this.accommodation});

  @override
  List<Object?> get props => [accommodation];
}

class AttractionDataLoaded extends SearchState {
  final Attraction attraction;

  AttractionDataLoaded({required this.attraction});

  @override
  List<Object?> get props => [attraction];
}
