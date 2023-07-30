import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/presentation/views/profile_view.dart';

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
      builder: (context, child) {
        return MaterialApp(
          home: ProfileView(),
        );
      },
    );
  }
}
