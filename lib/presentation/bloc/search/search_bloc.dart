import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slate/presentation/bloc/search/search_event.dart';
import 'package:slate/presentation/bloc/search/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitSearch()) {
    on<KeywordSearchEvent>(_keywordSearchEvent);
    on<MovieInfoSearchEvent>(_movieInfoSearchEvent);
    on<RestaurantInfoSearchEvent>(_restaurantInfoSearchEvent);
    on<AccommoInfoSearchEvent>(_accommoInfoSearchEvent);
    on<AttractionSearchEvent>(_attractionSearchEvent);
  }

  Future _keywordSearchEvent(
    KeywordSearchEvent event,
    Emitter<SearchState> emit,
  ) async {}

  Future _movieInfoSearchEvent(
    MovieInfoSearchEvent event,
    Emitter<SearchState> emit,
  ) async {}

  Future _restaurantInfoSearchEvent(
    RestaurantInfoSearchEvent event,
    Emitter<SearchState> emit,
  ) async {}

  Future _accommoInfoSearchEvent(
    AccommoInfoSearchEvent event,
    Emitter<SearchState> emit,
  ) async {}

  Future _attractionSearchEvent(
    AttractionSearchEvent event,
    Emitter<SearchState> emit,
  ) async {}
}
