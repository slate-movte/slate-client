import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/errors/failures.dart';
//레포import금지 //usecase생성해서 bloc->usecase->repository콜하도록만들기
//domain영역에 있는 usecase.. domain영역에서 repository를 만들고(interface-abstract), data영역에서 repository(도메인 영역에 선언된 레포를 받아)를 또 만들기
import 'package:slate/presentation/bloc/location_event.dart';
import 'package:slate/presentation/bloc/location_state.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/usecases/location_usecase.dart';
import '../../domain/usecases/marker_usecase.dart';
import 'marker_event.dart';
import 'marker_state.dart';

class MarkerBloc extends Bloc<MarkerEvent, MarkerState> {
  GetMarker getMarker;

  MarkerBloc({
    required this.getMarker
  }) : super(MarkerLoadedState(markerData: {} )) {
    on<MarkerLoadedEvent>(_getMarker);
  }

  Future _getMarker(
      MarkerLoadedEvent event,
      Emitter<MarkerState> emit,
      ) async {

    emit(MarkerLoadingState());
    String markerType = event.markerType;

    final result = await getMarker(markerType);

    result.fold(
            (failure){
          if(failure is ServerFailure){
            emit(MarkerErrorState(message: 'Get Marker Error'));
          }
        },
            (result){
              print("Bloc 마커 정보: " + result.toString());
          emit(MarkerLoadedState(markerData: result));

        }
    );
  }

}