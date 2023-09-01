import 'package:equatable/equatable.dart';

class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class KeywordSearchEvent extends SearchEvent {
  final String keyword;
  final int movieLastId;
  final int attractionLastId;

  KeywordSearchEvent({
    required this.keyword,
    required this.movieLastId,
    required this.attractionLastId,
  });
}

class MovieInfoSearchEvent extends SearchEvent {
  final int id;

  MovieInfoSearchEvent({required this.id});
}

class RestaurantInfoSearchEvent extends SearchEvent {
  final int id;

  RestaurantInfoSearchEvent({required this.id});
}

class AccommoInfoSearchEvent extends SearchEvent {
  final int id;

  AccommoInfoSearchEvent({required this.id});
}

class AttractionSearchEvent extends SearchEvent {
  final int id;

  AttractionSearchEvent({required this.id});
}
