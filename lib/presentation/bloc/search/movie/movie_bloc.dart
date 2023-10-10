import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/search_usecase.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieInfoSearch movieInfoSearch;

  MovieBloc({
    required this.movieInfoSearch,
  }) : super(InitSearch()) {
    on<MovieSearchEvent>(_movieInfoSearchEvent);
  }

  Future _movieInfoSearchEvent(
    MovieSearchEvent event,
    Emitter<MovieState> emit,
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
}
