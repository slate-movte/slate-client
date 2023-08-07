import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/presentation/views/home_view.dart';
import 'package:slate/presentation/views/sign_up_view.dart';
import 'package:slate/presentation/widgets/text_board.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('SLATE'),
            Column(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(327.w, 48.h),
                  ),
                  label: const Text('카카오톡으로 로그인'),
                  icon: const Icon(Icons.abc_rounded),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUpView()),
                    );
                  },
                ),
                TextBoard(
                  title: '감독',
                  content: 'ㅇㅇㅇ',
                  onTrailing: true,
                  trailing: Text('d'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
