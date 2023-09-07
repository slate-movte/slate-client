import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/data/repositories/camera_repository_impl.dart';
import 'package:slate/data/repositories/map_repository_impl.dart';
import 'package:slate/data/sources/native/camera_native_data_source.dart';
import 'package:slate/data/sources/remote/location_remote_data_source.dart';
import 'package:slate/data/sources/remote/map_remote_data_source.dart';
import 'package:slate/domain/repositories/camera_repository.dart';
import 'package:slate/domain/repositories/map_repository.dart';
import 'package:slate/domain/usecases/camera_usecase.dart';
import 'package:slate/domain/usecases/map_usecase.dart';
import 'package:slate/presentation/bloc/camera/camera_bloc.dart';
import 'package:slate/presentation/bloc/map/map_bloc.dart';

final DI = GetIt.instance;

// bloc
const String BLOC_CAMERA = 'BLOC_CAMERA';
const String BLOC_MAP = 'BLOC_MAP';

// usecase
const String USECASE_GET_CAMERA_CONTROLLER = 'USECASE_GET_CAMERA_CONTROLLER';
const String USECASE_CHANGE_CAMERA_DIRECTION =
    'USECASE_CHANGE_CAMERA_DIRECTION';
const String USECASE_TAKE_PICTURE = 'USECASE_TAKE_PICTURE';
const String USECASE_SAVE_PICTURE = 'USECASE_SAVE_PICTURE';
const String USECASE_GET_MARKER_WITH_TYPE = 'USECASE_GET_MARKER_WITH_TYPE';
const String USECASE_GET_CAMERA_POSITION = 'USECASE_GET_CAMERA_POSITION';

// repo
const String REPO_CAMERA = 'REPO_CAMERA';
const String REPO_MAP = 'REPO_MAP';

// data
const String DATA_CAMERA = 'DATA_CAMERA';
const String DATA_MAP = 'DATA_MAP';
const String DATA_LOCATION = 'DATA_LOCATION';

// core
const String CORE_LATLNG_BOUNDS = 'CORE_LATLNG_BOUNDS';

Future<void> init() async {
  // bloc
  DI.registerLazySingleton<CameraBloc>(
    () => CameraBloc(
      getCameraController: DI(instanceName: USECASE_GET_CAMERA_CONTROLLER),
      changeCameraDirection: DI(instanceName: USECASE_CHANGE_CAMERA_DIRECTION),
      takePicture: DI(instanceName: USECASE_TAKE_PICTURE),
      savePicture: DI(instanceName: USECASE_SAVE_PICTURE),
    ),
    instanceName: BLOC_CAMERA,
  );

  DI.registerLazySingleton<MapBloc>(
    () => MapBloc(
      getCameraPosition: DI(instanceName: USECASE_GET_CAMERA_POSITION),
      getMarkersWithType: DI(instanceName: USECASE_GET_MARKER_WITH_TYPE),
    ),
    instanceName: BLOC_MAP,
  );

  // usecase
  DI.registerLazySingleton<GetMarkersWithType>(
    () => GetMarkersWithType(
      repository: DI(instanceName: REPO_MAP),
    ),
    instanceName: USECASE_GET_MARKER_WITH_TYPE,
  );

  DI.registerLazySingleton<GetCameraPosition>(
    () => GetCameraPosition(
      repository: DI(instanceName: REPO_MAP),
    ),
    instanceName: USECASE_GET_CAMERA_POSITION,
  );

  DI.registerLazySingleton<SavePicture>(
    () => SavePicture(
      repository: DI(instanceName: REPO_CAMERA),
    ),
    instanceName: USECASE_SAVE_PICTURE,
  );

  DI.registerLazySingleton<ChangeCameraDirection>(
    () => ChangeCameraDirection(
      repository: DI(instanceName: REPO_CAMERA),
    ),
    instanceName: USECASE_CHANGE_CAMERA_DIRECTION,
  );

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

  // repository
  DI.registerLazySingleton<CameraRepository>(
    () => CameraRepositoryImpl(
      cameraDataSource: DI(instanceName: DATA_CAMERA),
    ),
    instanceName: REPO_CAMERA,
  );

  DI.registerLazySingleton<MapRepository>(
    () => MapRepositoryImpl(
      locationRemoteDataSource: DI(instanceName: DATA_LOCATION),
      mapRemoteDataSource: DI(instanceName: DATA_MAP),
    ),
    instanceName: REPO_MAP,
  );

  // datasource
  DI.registerLazySingleton<CameraNativeDataSource>(
    () => CameraNativeDataSourceImpl(),
    instanceName: DATA_CAMERA,
  );

  DI.registerLazySingleton<MapRemoteDataSource>(
    () => MapRemoteDataSourceImpl(),
    instanceName: DATA_MAP,
  );

  DI.registerLazySingleton<LocationRemoteDataSource>(
    () => LocationRemoteDataSourceImpl(),
    instanceName: DATA_LOCATION,
  );

  // core
  DI.registerLazySingleton<LatLngBounds>(
    () => LatLngBounds(
      northeast: const LatLng(35.2554, 129.2385),
      southwest: const LatLng(35.1062, 128.8606),
    ),
    instanceName: CORE_LATLNG_BOUNDS,
  );
}
