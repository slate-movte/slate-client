import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slate/domain/usecases/search_usecase.dart';
import 'package:slate/presentation/bloc/search/movie/movie_event.dart';
import 'package:slate/presentation/bloc/search/movie/movie_state.dart';
import 'package:slate/presentation/bloc/search/search_event.dart';

class MSearchBloc extends Bloc<MSearchEvent, MSearchState> {
  MovieInfoSearch movieInfoSearch;

  MovieLocationInfoSearch movieLocationInfoSearch;

  MSearchBloc({
    required this.movieInfoSearch,
    required this.movieLocationInfoSearch,
  }) : super(InitSearch()) {
    on<MovieSearchEvent>(_movieInfoSearchEvent);
    on<MovieLocationSearchEvent>(_movieLocationSearchEvent);
  }

  Future _movieInfoSearchEvent(
    MovieSearchEvent event,
    Emitter<MSearchState> emit,
  ) async {
    emit(InitSearch());
    final result = await movieInfoSearch(event.id);

    result.fold(
      (failure) {
        emit(MovieSearchError(message: 'ERROR'));
      },
      (movie) {
        emit(MovieDataLoaded(movie: movie));
      },
    );
  }

  Future _movieLocationSearchEvent(
    MovieLocationSearchEvent event,
    Emitter<MSearchState> emit,
  ) async {
    emit(InitSearch());
    final result = await movieLocationInfoSearch(event.id);

    result.fold(
      (failure) {
        emit(MovieLocationSearchError(message: 'ERROR'));
      },
      (movieLocation) {
        emit(MovieLocationDataLoaded(movieLocation: movieLocation));
      },
    );
  }
}
