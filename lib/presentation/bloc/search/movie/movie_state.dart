import 'package:equatable/equatable.dart';

import 'package:slate/domain/entities/movie.dart';
import 'package:slate/domain/entities/travel.dart';

class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitSearch extends MovieState {}

class DataLoading extends MovieState {}

class MovieDataLoaded extends MovieState {
  final Movie movie;

  MovieDataLoaded({required this.movie});

  @override
  List<Object?> get props => [movie];
}

class MovieSearchError extends MovieState {
  final String message;

  MovieSearchError({required this.message});

  @override
  List<Object?> get props => [message];
}
