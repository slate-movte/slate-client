import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/presentation/bloc/camera/camera_bloc.dart';
import 'package:slate/presentation/views/sign_in_view.dart';

import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
            create: (_) => DI.get<CameraBloc>(
              instanceName: BLOC_CAMERA,
            ),
          ),
        ],
        child: MaterialApp(
          theme: Themes.lite,
          debugShowCheckedModeBanner: false,
          home: SignInView(),
        ),
      ),
    );
  }
}
