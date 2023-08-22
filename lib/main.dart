import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/presentation/views/sign_in_view.dart';

void main() {
  runApp(const Slate());
}

class Slate extends StatelessWidget {
  const Slate({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.lite,
        home: const SignInView(),
      ),
    );
  }
}
