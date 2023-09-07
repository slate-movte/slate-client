import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';
import 'package:slate/data/repositories/camera_repository.dart';
import 'package:slate/data/sources/native/camera_native_data_source.dart';
import 'package:slate/domain/repositories/camera_repository.dart';
import 'package:slate/domain/usecases/camera_usecase.dart';
import 'package:slate/domain/usecases/marker_usecase.dart';
import 'package:slate/presentation/bloc/camera_bloc.dart';
import 'package:slate/presentation/bloc/location_bloc.dart';
import 'package:slate/presentation/bloc/marker_bloc.dart';

import 'data/repositories/location_repository.dart';
import 'data/repositories/marker_repository.dart';
import 'data/sources/remote/location_remote_data_source.dart';
import 'data/sources/remote/marker_remote_data_source.dart';
import 'domain/repositories/location_repository.dart';
import 'domain/repositories/marker_repository.dart';
import 'domain/usecases/location_usecase.dart';

final DI = GetIt.instance;

const String BLOC_CAMERA = 'BLOC_CAMERA';
const String USECASE_GET_CAMERA_CONTROLLER = 'USECASE_GET_CAMERA_CONTROLLER';
const String USECASE_TAKE_PICTURE = 'USECASE_TAKE_PICTURE';
const String REPO_CAMERA = 'REPO_CAMERA';
const String DATA_CAMERA = 'DATA_CAMERA';
const String CORE_CAMERA = 'CORE_CAMERA';

const String BLOC_LOCATION = 'BLOC_LOCATION';
const String USECASE_GET_LOCATION = 'USECASE_GET_LOCATION';
const String REPO_LOCATION = 'REPO_LOCATION';
const String DATA_LOCATION = 'DATA_LOCATION';

const String BLOC_MARKER = 'BLOC_MARKER';
const String USECASE_GET_MARKER = 'USECASE_GET_MARKER';
const String REPO_MARKER = 'REPO_MARKER';
const String DATA_MARKER = 'DATA_MARKER';

Future<void> init() async {
  // bloc
  DI.registerLazySingleton<CameraBloc>(
        () => CameraBloc(
      getCameraController: DI(instanceName: USECASE_GET_CAMERA_CONTROLLER),
      takePicture: DI(instanceName: USECASE_TAKE_PICTURE),
    ),
    instanceName: BLOC_CAMERA,
  );

  DI.registerLazySingleton<LocationBloc>(
        () => LocationBloc(
      getLocation: DI(instanceName: USECASE_GET_LOCATION),
    ),
    instanceName: BLOC_LOCATION,
  );

  DI.registerLazySingleton(
          () => MarkerBloc(
          getMarker: DI(instanceName: USECASE_GET_MARKER)
      ),
      instanceName: BLOC_MARKER
  );

  // usecase
  DI.registerLazySingleton<GetCameraController>(
        () => GetCameraController(
      repository: DI(instanceName: REPO_CAMERA),
    ),
    instanceName: USECASE_GET_CAMERA_CONTROLLER,
  );

  DI.registerLazySingleton<TakePicture>(
        () => TakePicture(
      repository: DI(instanceName: REPO_CAMERA),
    ),
    instanceName: USECASE_TAKE_PICTURE,
  );

  DI.registerLazySingleton<GetLocation>(
          () => GetLocation(repository: DI(instanceName: REPO_LOCATION)),
      instanceName: USECASE_GET_LOCATION
  );

  DI.registerLazySingleton<GetMarker>(
        () => GetMarkerInfo(repository: DI(instanceName: REPO_MARKER)),
    instanceName: USECASE_GET_MARKER,
  );

  // repository
  DI.registerLazySingleton<CameraRepository>(
        () => CameraRepositoryImpl(
      cameraDataSource: DI(instanceName: DATA_CAMERA),
    ),
    instanceName: REPO_CAMERA,
  );

  DI.registerLazySingleton<LocationRepository>(
          () => LocRepositoryImplementation(
        locDataSource: DI(instanceName: DATA_LOCATION)
      ),
      instanceName: REPO_LOCATION
  );

  DI.registerLazySingleton<MarkerRepository>(
          () => MarkerRepositoryImplementation(markerDataSource: DI(instanceName: DATA_MARKER), locationRemoteDataSource: DI(instanceName: DATA_LOCATION)),
      instanceName: REPO_MARKER
  );

  // datasource
  DI.registerLazySingleton<CameraNativeDataSource>(
        () => CameraNativeDataSourceImpl(),
    instanceName: DATA_CAMERA,
  );

  DI.registerLazySingleton<LocationRemoteDataSource>(
          () => LocationRemoteDataSourceImplementation(),
      instanceName: DATA_LOCATION
  );

  DI.registerLazySingleton<MarkerRemoteDataSource>(
          () => MarkerRemoteDataSourceImplementation(),
      instanceName: DATA_MARKER
  );

}
