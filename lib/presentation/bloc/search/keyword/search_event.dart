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
