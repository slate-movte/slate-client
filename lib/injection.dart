import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/data/repositories/camera_repository_impl.dart';
import 'package:slate/data/repositories/course_repository_impl.dart';
import 'package:slate/data/repositories/map_repository_impl.dart';
import 'package:slate/data/repositories/search_repository_impl.dart';
import 'package:slate/data/sources/native/camera_native_data_source.dart';
import 'package:slate/data/sources/remote/location_remote_data_source.dart';
import 'package:slate/data/sources/remote/map_remote_data_source.dart';
import 'package:slate/data/sources/remote/search_api_remote_data_source.dart';
import 'package:slate/domain/repositories/camera_repository.dart';
import 'package:slate/domain/repositories/map_repository.dart';
import 'package:slate/domain/repositories/search_repository.dart';
import 'package:slate/domain/usecases/camera_usecase.dart';
import 'package:slate/domain/usecases/map_usecase.dart';
import 'package:slate/domain/usecases/search_usecase.dart';
import 'package:slate/presentation/bloc/camera/camera_bloc.dart';
import 'package:slate/presentation/bloc/course/course_bloc.dart';
import 'package:slate/presentation/bloc/map/map_bloc.dart';
import 'package:slate/presentation/bloc/search/search_bloc.dart';

import 'data/sources/remote/course_api_remote_data_source.dart';
import 'domain/repositories/course_repository.dart';
import 'domain/usecases/course_usecase.dart';

final DI = GetIt.instance;

// bloc
const String BLOC_CAMERA = 'BLOC_CAMERA';
const String BLOC_MAP = 'BLOC_MAP';
const String BLOC_COURSE = 'BLOC_COURSE';
const String BLOC_SEARCH = 'BLOC_SEARCH';

// usecase
const String USECASE_GET_CAMERA_CONTROLLER = 'USECASE_GET_CAMERA_CONTROLLER';
const String USECASE_CHANGE_CAMERA_DIRECTION =
    'USECASE_CHANGE_CAMERA_DIRECTION';
const String USECASE_TAKE_PICTURE = 'USECASE_TAKE_PICTURE';
const String USECASE_SAVE_PICTURE = 'USECASE_SAVE_PICTURE';
const String USECASE_GET_MARKER_WITH_TYPE = 'USECASE_GET_MARKER_WITH_TYPE';
const String USECASE_GET_CAMERA_POSITION = 'USECASE_GET_CAMERA_POSITION';
const String USECASE_DISPOSE_CAMERA = 'USECASE_DISPOSE_CAMERA';
const String USECASE_GET_ALLCOURSE = 'USECASE_GET_ALLCOURSE';
const String USECASE_GET_INFOCOURSE = 'USECASE_GET_INFOCOURSE';
const String USECASE_KEYWORD_SEARCH = 'USECASE_KEYWORD_SEARCH';
const String USECASE_MOVIE_INFO_SEARCH = 'USECASE_MOVIE_INFO_SEARCH';
const String USECASE_RESTAURANT_INFO_SEARCH = 'USECASE_RESTAURANT_INFO_SEARCH';
const String USECASE_ACCOMO_INFO_SEARCH = 'USECASE_ACCOMO_INFO_SEARCH';
const String USECASE_ATTRACTION_INFO_SEARCH = 'USECASE_ATTRACTION_INFO_SEARCH';

// repo
const String REPO_CAMERA = 'REPO_CAMERA';
const String REPO_MAP = 'REPO_MAP';
const String REPO_COURSE = 'REPO_COURSE';
const String REPO_SEARCH = 'REPO_SEARCH';

// data
const String DATA_CAMERA = 'DATA_CAMERA';
const String DATA_MAP = 'DATA_MAP';
const String DATA_LOCATION = 'DATA_LOCATION';
const String DATA_COURSE = 'DATA_COURSE';
const String DATA_SEARCH = 'DATA_SEARCH';

// core
const String CORE_LATLNG_BOUNDS = 'CORE_LATLNG_BOUNDS';

Future<void> init() async {
  // bloc
  DI.registerLazySingleton<CameraBloc>(
    () => CameraBloc(
        getCameraController: DI(instanceName: USECASE_GET_CAMERA_CONTROLLER),
        changeCameraDirection:
            DI(instanceName: USECASE_CHANGE_CAMERA_DIRECTION),
        takePicture: DI(instanceName: USECASE_TAKE_PICTURE),
        savePicture: DI(instanceName: USECASE_SAVE_PICTURE),
        disposeCamera: DI(instanceName: USECASE_DISPOSE_CAMERA)),
    instanceName: BLOC_CAMERA,
  );

  DI.registerLazySingleton<MapBloc>(
    () => MapBloc(
      getCameraPosition: DI(instanceName: USECASE_GET_CAMERA_POSITION),
      getMarkersWithType: DI(instanceName: USECASE_GET_MARKER_WITH_TYPE),
    ),
    instanceName: BLOC_MAP,
  );

  DI.registerLazySingleton<CourseBloc>(
    () => CourseBloc(
      allCourse: DI(instanceName: USECASE_GET_ALLCOURSE),
      infoCourse: DI(instanceName: USECASE_GET_INFOCOURSE),
    ),
    instanceName: BLOC_COURSE,
  );

  DI.registerLazySingleton<SearchBloc>(
    () => SearchBloc(
      keywordSearch: DI(instanceName: USECASE_KEYWORD_SEARCH),
      movieInfoSearch: DI(instanceName: USECASE_MOVIE_INFO_SEARCH),
      restaurantInfoSearch: DI(instanceName: USECASE_RESTAURANT_INFO_SEARCH),
      accommoInfoSearch: DI(instanceName: USECASE_ACCOMO_INFO_SEARCH),
      attractionInfoSearch: DI(instanceName: USECASE_ATTRACTION_INFO_SEARCH),
    ),
    instanceName: BLOC_SEARCH,
  );

  // usecase
  DI.registerLazySingleton<KeywordSearch>(
    () => KeywordSearch(
      repository: DI(instanceName: REPO_SEARCH),
    ),
    instanceName: USECASE_KEYWORD_SEARCH,
  );

  DI.registerLazySingleton<MovieInfoSearch>(
    () => MovieInfoSearch(
      repository: DI(instanceName: REPO_SEARCH),
    ),
    instanceName: USECASE_MOVIE_INFO_SEARCH,
  );

  DI.registerLazySingleton<RestaurantInfoSearch>(
    () => RestaurantInfoSearch(
      repository: DI(instanceName: REPO_SEARCH),
    ),
    instanceName: USECASE_RESTAURANT_INFO_SEARCH,
  );

  DI.registerLazySingleton<AccommoInfoSearch>(
    () => AccommoInfoSearch(
      repository: DI(instanceName: REPO_SEARCH),
    ),
    instanceName: USECASE_ACCOMO_INFO_SEARCH,
  );

  DI.registerLazySingleton<AttractionInfoSearch>(
    () => AttractionInfoSearch(
      repository: DI(instanceName: REPO_SEARCH),
    ),
    instanceName: USECASE_ATTRACTION_INFO_SEARCH,
  );

  DI.registerLazySingleton<DisposeCamera>(
    () => DisposeCamera(
      repository: DI(instanceName: REPO_CAMERA),
    ),
    instanceName: USECASE_DISPOSE_CAMERA,
  );

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

  DI.registerLazySingleton<AllCourse>(
    () => AllCourse(
      repository: DI(instanceName: REPO_COURSE),
    ),
    instanceName: USECASE_GET_ALLCOURSE,
  );

  DI.registerLazySingleton<InfoCourse>(
    () => InfoCourse(
      repository: DI(instanceName: REPO_COURSE),
    ),
    instanceName: USECASE_GET_INFOCOURSE,
  );

  // repository
  DI.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      dataSource: DI(instanceName: DATA_SEARCH),
    ),
    instanceName: REPO_SEARCH,
  );

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

  DI.registerLazySingleton<CourseRepository>(
    () => CourseRepositoryImpl(
      dataSource: DI(instanceName: DATA_COURSE),
    ),
    instanceName: REPO_COURSE,
  );

  // datasource
  DI.registerLazySingleton<SearchApiRemoteDataSource>(
    () => SearchApiRemoteDataSourceImpl(),
    instanceName: DATA_SEARCH,
  );

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

  DI.registerLazySingleton<CourseApiRemoteDataSource>(
    () => CourseApiRemoteDataSourceImpl(),
    instanceName: DATA_COURSE,
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
