import 'package:equatable/equatable.dart';

import 'package:slate/domain/entities/movie.dart';
import 'package:slate/domain/entities/travel.dart';

class MSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitSearch extends MSearchState {}

class DataLoading extends MSearchState {}

class MovieDataLoaded extends MSearchState {
  final Movie movie;

  MovieDataLoaded({required this.movie});

  @override
  List<Object?> get props => [movie];
}

class MovieLocationDataLoaded extends MSearchState {
  final MovieLocation movieLocation;

  MovieLocationDataLoaded({required this.movieLocation});

  @override
  List<Object?> get props => [movieLocation];
}

class MovieSearchError extends MSearchState {
  final String message;

  MovieSearchError({required this.message});

  @override
  List<Object?> get props => [message];
}

class MovieLocationSearchError extends MSearchState {
  final String message;

  MovieLocationSearchError({required this.message});

  @override
  List<Object?> get props => [message];
}
