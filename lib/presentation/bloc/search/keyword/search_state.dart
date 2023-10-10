import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitSearch extends SearchState {}

class SearchDataLoading extends SearchState {}

class KeywordDataLoaded extends SearchState {
  final List dataList;
  final bool endData;

  KeywordDataLoaded({
    required this.dataList,
    this.endData = false,
  });

  @override
  List<Object?> get props => [dataList];
}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});

  @override
  List<Object?> get props => [message];
}
