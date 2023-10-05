import 'package:equatable/equatable.dart';

class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class KeywordSearchEvent extends SearchEvent {
  final bool refresh;
  final String? keyword;

  KeywordSearchEvent({
    this.refresh = false,
    this.keyword,
  });
}

class RefreshSearchEvent extends SearchEvent {}

class LoadMoreDataEvent extends SearchEvent {}

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

class AttractionInfoSearchEvent extends SearchEvent {
  final int id;

  AttractionInfoSearchEvent({required this.id});
}

class MovieLocationInfoSearchEvent extends SearchEvent {
  final int id;

  MovieLocationInfoSearchEvent({required this.id});
}
