import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/search_usecase.dart';
import 'travel_event.dart';
import 'travel_state.dart';

class TravelBloc extends Bloc<TravelEvent, TravelState> {
  RestaurantInfoSearch restaurantInfoSearch;
  AccommoInfoSearch accommoInfoSearch;
  AttractionInfoSearch attractionInfoSearch;
  MovieLocationInfoSearch movieLocationInfoSearch;

  TravelBloc({
    required this.restaurantInfoSearch,
    required this.accommoInfoSearch,
    required this.attractionInfoSearch,
    required this.movieLocationInfoSearch,
  }) : super(TravelDataLoading()) {
    on<GetRestaurantInfoEvent>(_getRestaurantInfoEvent);
    on<GetAccommoInfoEvent>(_getAccommoInfoEvent);
    on<GetAttractionInfoEvent>(_getAttractionInfoEvent);
    on<GetMovieLocationInfoEvent>(_getMovieLocationInfoEvent);
  }

  Future _getRestaurantInfoEvent(
    GetRestaurantInfoEvent event,
    Emitter<TravelState> emit,
  ) async {
    emit(TravelDataLoading());
    final result = await restaurantInfoSearch(event.id);
    result.fold(
      (failure) {
        emit(TravelSearchError(message: 'ERROR'));
      },
      (restaurant) {
        emit(RestaurantDataLoaded(restaurant: restaurant));
      },
    );
  }

  Future _getAccommoInfoEvent(
    GetAccommoInfoEvent event,
    Emitter<TravelState> emit,
  ) async {
    emit(TravelDataLoading());
    final result = await accommoInfoSearch(event.id);

    result.fold(
      (failure) {
        emit(TravelSearchError(message: 'ERROR'));
      },
      (accommo) {
        emit(AccommoDataLoaded(accommodation: accommo));
      },
    );
  }

  Future _getAttractionInfoEvent(
    GetAttractionInfoEvent event,
    Emitter<TravelState> emit,
  ) async {
    emit(TravelDataLoading());
    final result = await attractionInfoSearch(event.id);

    result.fold(
      (failure) {
        emit(TravelSearchError(message: 'ERROR'));
      },
      (attraction) {
        emit(AttractionDataLoaded(attraction: attraction));
      },
    );
  }

  Future _getMovieLocationInfoEvent(
    GetMovieLocationInfoEvent event,
    Emitter<TravelState> emit,
  ) async {
    emit(TravelDataLoading());
    final result = await movieLocationInfoSearch(event.id);

    result.fold(
      (failure) {
        emit(TravelSearchError(message: 'ERROR'));
      },
      (movieLocation) {
        emit(MovieLocationDataLoaded(movieLocation: movieLocation));
      },
    );
  }
}
