import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:slate/core/utils/assets.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/presentation/views/main_view.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.APP_LOGO.path,
              width: 212.w,
              height: 85.h,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeOf.w_lg),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorOf.black.light,
                    ),
                    onPressed: () async {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const MainView()),
                      );
                    },
                    child: const Text('비회원으로 둘러보기'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
