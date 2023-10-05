import 'package:equatable/equatable.dart';

class MovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieSearchEvent extends MovieEvent {
  final int id;

  MovieSearchEvent({required this.id});
}
