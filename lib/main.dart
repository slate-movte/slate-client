import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/core/caches/slate_auth.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/presentation/bloc/camera/camera_bloc.dart';
import 'package:slate/presentation/bloc/course/course_bloc.dart';
import 'package:slate/presentation/bloc/map/map_bloc.dart';
import 'package:slate/presentation/views/sign_in_view.dart';
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // KakaoSdk.init(nativeAppKey: '95c71c63e60de73eca63343269998377');
  // UserApi.instance.signup();
  // UserApi.instance.accessTokenInfo();
  // UserApi.instance.logout();
  // try {
  //   AccessTokenInfo info = await UserApi.instance.accessTokenInfo();
  //   log(info.toString());
  // } catch (e) {
  //   log('로그인한 상태 아님XXXXXX');
  // }

  // User user = await UserApi.instance.me();
  // log(user.toString());

  await init();

  // final camera = await availableCameras();
  // log(camera.toString());

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
            create: (_) => DI.get<CourseBloc>(
              instanceName: BLOC_COURSE,
            ),
          ),
        ],
        child: MaterialApp(
          theme: Themes.lite,
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: SlateAuth().authStateChanges(),
            builder: (context, snapshot) {
              return SignInView();
            },
          ),
        ),
      ),
    );
  }
}
