import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/core/utils/assets.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/presentation/views/main_view.dart';
import 'package:slate/presentation/views/sign_up_view.dart';

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
            SizedBox(height: 60.h),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUpView()),
                    );
                  },
                  child: Image.asset(
                    Images.KAKAO_OAUTH.path,
                    width: 327.w,
                    height: 48.h,
                  ),
                ),
                SizedBox(height: SizeOf.h_sm),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MainView()),
                    );
                  },
                  child: Text('비회원으로 둘러보기'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
