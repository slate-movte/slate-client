// ignore_for_file: unused_import, non_constant_identifier_names, constant_identifier_names

import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'data/sources/native/camera_native_data_source.dart';
import 'data/sources/remote/course_api_remote_data_source.dart';
import 'data/sources/remote/location_remote_data_source.dart';
import 'data/sources/remote/map_remote_data_source.dart';
import 'data/sources/remote/scene_api_remote_data_source.dart';
import 'data/sources/remote/search_api_remote_data_source.dart';
import 'data/repositories/camera_repository_impl.dart';
import 'data/repositories/course_repository_impl.dart';
import 'data/repositories/map_repository_impl.dart';
import 'data/repositories/scene_repository_impl.dart';
import 'data/repositories/search_repository_impl.dart';

import 'domain/usecases/camera_usecase.dart';
import 'domain/usecases/course_usecase.dart';
import 'domain/usecases/map_usecase.dart';
import 'domain/usecases/scene_usecase.dart';
import 'domain/usecases/search_usecase.dart';
import 'domain/repositories/camera_repository.dart';
import 'domain/repositories/course_repository.dart';
import 'domain/repositories/map_repository.dart';
import 'domain/repositories/scene_repository.dart';
import 'domain/repositories/search_repository.dart';

import 'presentation/bloc/camera/camera_bloc.dart';
import 'presentation/bloc/course/course_bloc.dart';
import 'presentation/bloc/map/map_bloc.dart';
import 'presentation/bloc/scene/scene_bloc.dart';
import 'presentation/bloc/search/keyword/search_bloc.dart';
import 'presentation/bloc/search/movie/movie_bloc.dart';
import 'presentation/bloc/search/travel/travel_bloc.dart';

final DI = GetIt.instance;

// bloc
const String BLOC_CAMERA = 'BLOC_CAMERA';
const String BLOC_MAP = 'BLOC_MAP';
const String BLOC_COURSE = 'BLOC_COURSE';
const String BLOC_SEARCH = 'BLOC_SEARCH';
const String BLOC_SCENE = 'BLOC_SCENE';
const String BLOC_MOVIE = 'BLOC_MOVIE';
const String BLOC_TRAVEL = 'BLOC_TRAVEL';

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
const String USECASE_GET_SCENES_WITH_MOVIE_TITLE =
    'USECASE_GET_SCENES_WITH_MOVIE_TITLE';
const String USECASE_MOVIELOCATION_INFO_SEARCH =
    'USECASE_MOVIELOCATION_INFO_SEARCH';

// repo
const String REPO_CAMERA = 'REPO_CAMERA';
const String REPO_MAP = 'REPO_MAP';
const String REPO_COURSE = 'REPO_COURSE';
const String REPO_SEARCH = 'REPO_SEARCH';
const String REPO_SCENE = 'REPO_SCENE';

// data
const String DATA_CAMERA = 'DATA_CAMERA';
const String DATA_MAP = 'DATA_MAP';
const String DATA_LOCATION = 'DATA_LOCATION';
const String DATA_COURSE = 'DATA_COURSE';
const String DATA_SEARCH = 'DATA_SEARCH';
const String DATA_SCENE = 'DATA_SCENE';

// core
const String CORE_LATLNG_BOUNDS = 'CORE_LATLNG_BOUNDS';

Future<void> init() async {
  // bloc
  DI.registerLazySingleton<SceneBloc>(
    () => SceneBloc(
      getScenesWithMovieTitle:
          DI(instanceName: USECASE_GET_SCENES_WITH_MOVIE_TITLE),
    ),
    instanceName: BLOC_SCENE,
  );

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
      getAllCourseInfo: DI(instanceName: USECASE_GET_ALLCOURSE),
      getCourseWithId: DI(instanceName: USECASE_GET_INFOCOURSE),
    ),
    instanceName: BLOC_COURSE,
  );

  DI.registerLazySingleton<SearchBloc>(
    () => SearchBloc(
      keywordSearch: DI(instanceName: USECASE_KEYWORD_SEARCH),
    ),
    instanceName: BLOC_SEARCH,
  );

  DI.registerLazySingleton<MovieBloc>(
    () => MovieBloc(
      movieInfoSearch: DI(instanceName: USECASE_MOVIE_INFO_SEARCH),
    ),
    instanceName: BLOC_MOVIE,
  );

  DI.registerLazySingleton<TravelBloc>(
    () => TravelBloc(
      restaurantInfoSearch: DI(instanceName: USECASE_RESTAURANT_INFO_SEARCH),
      accommoInfoSearch: DI(instanceName: USECASE_ACCOMO_INFO_SEARCH),
      attractionInfoSearch: DI(instanceName: USECASE_ATTRACTION_INFO_SEARCH),
      movieLocationInfoSearch:
          DI(instanceName: USECASE_MOVIELOCATION_INFO_SEARCH),
    ),
    instanceName: BLOC_TRAVEL,
  );

  // usecase
  DI.registerLazySingleton<GetScenesWithMovieTitle>(
    () => GetScenesWithMovieTitle(
      repository: DI(instanceName: REPO_SCENE),
    ),
    instanceName: USECASE_GET_SCENES_WITH_MOVIE_TITLE,
  );

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

  DI.registerLazySingleton<MovieLocationInfoSearch>(
    () => MovieLocationInfoSearch(
      repository: DI(instanceName: REPO_SEARCH),
    ),
    instanceName: USECASE_MOVIELOCATION_INFO_SEARCH,
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

  DI.registerLazySingleton<GetAllCourseInfo>(
    () => GetAllCourseInfo(
      repository: DI(instanceName: REPO_COURSE),
    ),
    instanceName: USECASE_GET_ALLCOURSE,
  );

  DI.registerLazySingleton<GetCourseWithId>(
    () => GetCourseWithId(
      repository: DI(instanceName: REPO_COURSE),
    ),
    instanceName: USECASE_GET_INFOCOURSE,
  );

  // repository
  DI.registerLazySingleton<SceneRepository>(
    () => SceneRepositoryImpl(
      dataSource: DI(instanceName: DATA_SCENE),
    ),
    instanceName: REPO_SCENE,
  );

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
  DI.registerLazySingleton<SceneApiRemoteDataSource>(
    () => SceneApiRemoteDataSourceImpl(),
    instanceName: DATA_SCENE,
  );

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
