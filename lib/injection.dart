import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';
import 'package:slate/data/repositories/camera_repository.dart';
import 'package:slate/data/sources/native/camera_native_data_source.dart';
import 'package:slate/domain/repositories/camera_repository.dart';
import 'package:slate/domain/usecases/camera_usecase.dart';
import 'package:slate/presentation/bloc/camera/camera_bloc.dart';

final DI = GetIt.instance;

const String BLOC_CAMERA = 'BLOC_CAMERA';
const String USECASE_GET_CAMERA_CONTROLLER = 'USECASE_GET_CAMERA_CONTROLLER';
const String USECASE_TAKE_PICTURE = 'USECASE_TAKE_PICTURE';
const String REPO_CAMERA = 'REPO_CAMERA';
const String DATA_CAMERA = 'DATA_CAMERA';
const String CORE_CAMERA = 'CORE_CAMERA';

Future<void> init() async {
  // bloc
  DI.registerLazySingleton<CameraBloc>(
    () => CameraBloc(
      getCameraController: DI(instanceName: USECASE_GET_CAMERA_CONTROLLER),
      takePicture: DI(instanceName: USECASE_TAKE_PICTURE),
    ),
    instanceName: BLOC_CAMERA,
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

  // repository
  DI.registerLazySingleton<CameraRepository>(
    () => CameraRepositoryImpl(
      cameraDataSource: DI(instanceName: DATA_CAMERA),
    ),
    instanceName: REPO_CAMERA,
  );
  // datasource

  DI.registerLazySingleton<CameraNativeDataSource>(
    () => CameraNativeDataSourceImpl(),
    instanceName: DATA_CAMERA,
  );
}
