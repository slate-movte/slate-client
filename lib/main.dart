import 'package:flutter/material.dart';
import 'package:slate/presentation/views/movie_info_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const Slate());
}

class Slate extends StatefulWidget {
  const Slate({super.key});

  @override
  State<Slate> createState() => _SlateState();
}

class _SlateState extends State<Slate> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(393,852),
        builder: (context, child) {
          return MaterialApp(
            home: Scaffold(
              body: MovieInfoView(),
            ),
          );
        }
    );
  }
}
