import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/entities/travel.dart';
import '../../../../domain/usecases/search_usecase.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  KeywordSearch keywordSearch;

  String keyword = "";
  int movieLastId = 0;
  int attractionLastId = 0;

  SearchBloc({
    required this.keywordSearch,
  }) : super(InitSearch()) {
    on<KeywordSearchEvent>(_keywordSearchEvent);
  }

  Future _keywordSearchEvent(
    KeywordSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    keyword = event.keyword ?? "";

    if (event.refresh) {
      movieLastId = 0;
      attractionLastId = 0;
      emit(InitSearch());
    } else {
      emit(SearchDataLoading());
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
}
