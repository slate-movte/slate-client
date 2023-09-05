import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/presentation/bloc/permission_event.dart';
import 'package:slate/presentation/bloc/permission_state.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/usecases/permission_usecase.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  GetPermission getPermission;
  SetPermission setPermission;

  PermissionBloc({
    required this.getPermission,
    required this.setPermission
  }) : super(PermissionDenyState()) {
    on<PermissionGetEvent>(getPermissionStatus);
  }

  Future<void> getPermissionStatus(
      PermissionEvent event,
      Emitter<PermissionState> emit,) async {

    emit(PermissionAcceptState());

    final result = await getPermission(NoParams());

    result.fold(
            (failure){
          if(failure is PermissionFailure){
            emit(PermissionDenyState());
          }
        },
            (result){
              if(result==false) {
                emit(PermissionAcceptState());
              }else{
                emit(PermissionDenyState());
              };
        }
    );

  }

  Future<void> setPermissionStatus() async {
    await setPermission(NoParams());
  }
}