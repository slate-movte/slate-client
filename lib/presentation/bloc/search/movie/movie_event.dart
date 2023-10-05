import 'package:equatable/equatable.dart';

class MSearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieSearchEvent extends MSearchEvent {
  final int id;

  MovieSearchEvent({required this.id});
}

class MovieLocationSearchEvent extends MSearchEvent {
  final int id;

  MovieLocationSearchEvent({required this.id});
}
