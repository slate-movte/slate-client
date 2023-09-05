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

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  GetLocation getLocation;

  LocationBloc({
    required this.getLocation
  }) : super(LocationLoadedState(locationData: LatLng(35.171585, 129.127796))) {
    on<UpdateLocationEvent>(_updateLocation);
  }

  Future _updateLocation(
        UpdateLocationEvent event,
        Emitter<LocationState> emit,
      ) async {

    emit(LocationLoadingState());

    final result = await getLocation(NoParams());

    result.fold(
        (failure){
          if(failure is ServerFailure){
            //final LatLng _center = const LatLng(35.171585, 129.127796);
            emit(LocationErrorState(message: 'Get Location Error'));
          }
        },
        (result){
          emit(LocationLoadedState(locationData: result));
        }
    );
  }

}