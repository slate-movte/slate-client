import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slate/domain/entities/movie.dart';
import 'package:slate/domain/entities/travel.dart';
import 'package:slate/domain/usecases/search_usecase.dart';
import 'package:slate/presentation/bloc/search/search_event.dart';
import 'package:slate/presentation/bloc/search/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  KeywordSearch keywordSearch;
  MovieInfoSearch movieInfoSearch;
  RestaurantInfoSearch restaurantInfoSearch;
  AccommoInfoSearch accommoInfoSearch;
  AttractionInfoSearch attractionInfoSearch;
  MovieLocationInfoSearch movieLocationInfoSearch;

  String keyword = "";
  int movieLastId = 0;
  int attractionLastId = 0;

  SearchBloc({
    required this.keywordSearch,
    required this.movieInfoSearch,
    required this.restaurantInfoSearch,
    required this.accommoInfoSearch,
    required this.attractionInfoSearch,
    required this.movieLocationInfoSearch,
  }) : super(InitSearch()) {
    on<KeywordSearchEvent>(_keywordSearchEvent);
    on<MovieInfoSearchEvent>(_movieInfoSearchEvent);
    on<RestaurantInfoSearchEvent>(_restaurantInfoSearchEvent);
    on<AccommoInfoSearchEvent>(_accommoInfoSearchEvent);
    on<AttractionInfoSearchEvent>(_attractionSearchEvent);
    on<MovieLocationInfoSearchEvent>(_movieLocationSearchEvent);
  }

  Future _keywordSearchEvent(
    KeywordSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    keyword = event.keyword ?? "";
    print(keyword);

    if (event.refresh) {
      movieLastId = 0;
      attractionLastId = 0;
      emit(InitSearch());
    } else {
      emit(DataLoading());
    }

    final result = await keywordSearch((
      keyword,
      movieLastId,
      attractionLastId,
    ));

    result.fold(
      (failure) {
        emit(SearchError(message: 'ERROR'));
      },
      (list) {
        log(list.toString());
        List items = [];
        items.addAll(List<Movie>.from(list['movie']!));
        items.addAll(List<Travel>.from(list['attraction']!));
        items.shuffle();

        movieLastId += 5;
        attractionLastId += 5;

        if (list['movie']!.isEmpty || list['movie']!.length != 5) {
          movieLastId = -1;
        }

        if (list['attraction']!.isEmpty || list['attraction']!.length != 5) {
          attractionLastId = -1;
        }

        emit(
          KeywordDataLoaded(
            dataList: items,
            endData: movieLastId == -1 && attractionLastId == -1,
          ),
        );
      },
    );
  }

  Future _movieInfoSearchEvent(
    MovieInfoSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(InitSearch());
    final result = await movieInfoSearch(event.id);

    result.fold(
      (failure) {
        emit(SearchError(message: 'ERROR'));
      },
      (movie) {
        emit(MovieDataLoaded(movie: movie));
      },
    );
  }

  Future _restaurantInfoSearchEvent(
    RestaurantInfoSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(InitSearch());
    final result = await restaurantInfoSearch(event.id);
    result.fold(
      (failure) {
        emit(SearchError(message: 'ERROR'));
      },
      (restaurant) {
        emit(RestaurantDataLoaded(restaurant: restaurant));
      },
    );
  }

  Future _accommoInfoSearchEvent(
    AccommoInfoSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(InitSearch());
    final result = await accommoInfoSearch(event.id);

    result.fold(
      (failure) {
        emit(SearchError(message: 'ERROR'));
      },
      (accommo) {
        emit(AccommoDataLoaded(accommodation: accommo));
      },
    );
  }

  Future _attractionSearchEvent(
    AttractionInfoSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(InitSearch());
    final result = await attractionInfoSearch(event.id);

    result.fold(
      (failure) {
        emit(SearchError(message: 'ERROR'));
      },
      (attraction) {
        emit(AttractionDataLoaded(attraction: attraction));
      },
    );
  }

  Future _movieLocationSearchEvent(
    MovieLocationInfoSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(InitSearch());
    final result = await movieLocationInfoSearch(event.id);

    result.fold(
      (failure) {
        emit(SearchError(message: 'ERROR'));
      },
      (movieLocation) {
        emit(MovieLocationDataLoaded(movieLocation: movieLocation));
      },
    );
  }
}
