import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'presentation/bloc/camera/camera_bloc.dart';
import 'presentation/bloc/course/course_bloc.dart';
import 'presentation/bloc/map/map_bloc.dart';
import 'presentation/bloc/scene/scene_bloc.dart';
import 'presentation/bloc/search/keyword/search_bloc.dart';
import 'presentation/bloc/search/movie/movie_bloc.dart';
import 'presentation/bloc/search/travel/travel_bloc.dart';
import 'presentation/views/sign_in_view.dart';
import 'core/utils/themes.dart';

import 'injection.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await init();
  await availableCameras();
  FlutterNativeSplash.remove();
  runApp(const Slate());
}

class Slate extends StatelessWidget {
  const Slate({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => DI.get<CameraBloc>(
              instanceName: BLOC_CAMERA,
            ),
          ),
          BlocProvider(
            create: (_) => DI.get<MapBloc>(
              instanceName: BLOC_MAP,
            ),
          ),
          BlocProvider(
            create: (_) => DI.get<SearchBloc>(
              instanceName: BLOC_SEARCH,
            ),
          ),
          BlocProvider(
            create: (_) => DI.get<SceneBloc>(
              instanceName: BLOC_SCENE,
            ),
          ),
          BlocProvider(
            create: (_) => DI.get<CourseBloc>(
              instanceName: BLOC_COURSE,
            ),
          ),
          BlocProvider(
            create: (_) => DI.get<TravelBloc>(
              instanceName: BLOC_TRAVEL,
            ),
          ),
          BlocProvider(
            create: (_) => DI.get<MovieBloc>(
              instanceName: BLOC_MOVIE,
            ),
          ),
        ],
        child: MaterialApp(
          theme: Themes.lite,
          debugShowCheckedModeBanner: false,
          home: const SignInView(),
        ),
      ),
    );
  }
}
