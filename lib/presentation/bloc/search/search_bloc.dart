import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slate/domain/usecases/search_usecase.dart';
import 'package:slate/presentation/bloc/search/search_event.dart';
import 'package:slate/presentation/bloc/search/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  KeywordSearch keywordSearch;
  MovieInfoSearch movieInfoSearch;
  RestaurantInfoSearch restaurantInfoSearch;
  AccommoInfoSearch accommoInfoSearch;
  AttractionInfoSearch attractionInfoSearch;

  SearchBloc({
    required this.keywordSearch,
    required this.movieInfoSearch,
    required this.restaurantInfoSearch,
    required this.accommoInfoSearch,
    required this.attractionInfoSearch,
  }) : super(InitSearch()) {
    on<KeywordSearchEvent>(_keywordSearchEvent);
    on<MovieInfoSearchEvent>(_movieInfoSearchEvent);
    on<RestaurantInfoSearchEvent>(_restaurantInfoSearchEvent);
    on<AccommoInfoSearchEvent>(_accommoInfoSearchEvent);
    on<AttractionInfoSearchEvent>(_attractionSearchEvent);
  }

  Future _keywordSearchEvent(
    KeywordSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(InitSearch());
    final result = await keywordSearch((
      event.keyword,
      event.movieLastId,
      event.attractionLastId,
    ));

    result.fold((failure) => null, (list) => null);
  }

  Future _movieInfoSearchEvent(
    MovieInfoSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(InitSearch());
    final result = await movieInfoSearch(event.id);

    result.fold((failure) => null, (movie) => null);
  }

  Future _restaurantInfoSearchEvent(
    RestaurantInfoSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(InitSearch());
    final result = await restaurantInfoSearch(event.id);

    result.fold((failure) => null, (restaurant) => null);
  }

  Future _accommoInfoSearchEvent(
    AccommoInfoSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(InitSearch());
    final result = await accommoInfoSearch(event.id);

    result.fold((failure) => null, (accommo) => null);
  }

  Future _attractionSearchEvent(
    AttractionInfoSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(InitSearch());
    final result = await attractionInfoSearch(event.id);

    result.fold((failure) => null, (attraction) => null);
  }
}
