import 'package:flutter/material.dart';
import 'package:slate/presentation/views/sign_up_view.dart';
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
        designSize: Size(393, 852),
        builder: (context, child) {
          return MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                  title: Text(
                    '회원가입',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context); //뒤로가기
                      },
                      color: Colors.black,
                      icon: Icon(Icons.arrow_back_ios)),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0),
              body: SignUpView(),
            ),
          );
        });
  }
}
