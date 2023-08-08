import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/presentation/views/home_view.dart';
import 'package:slate/presentation/views/sign_up_view.dart';

import '../widgets/image-board.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});


  @override
  Widget build(BuildContext context) {

    List<String>? nameList = ["설경구", "박보영"]; //??
    List<String>? photoList = ["hello", "good"]; //??

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
                ImageBoard(
                  title: "해운대",
                  subtitle: "영화",
                  isName: true,
                  actorLabels: Row(
                    children: [
                      for(int i=0; i<nameList.length; i++)
                        Text(nameList[i])
                    ],
                  ),
                  isPhoto: true,
                  photoCarousel: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for(int i=0; i<photoList.length; i++)
                          Container(
                            width: 117.w,
                            height: 74.h,
                            margin: EdgeInsets.only(left: 2.w, right: 2.w),
                            child:
                            Placeholder(), //Image.assets('Haeundae_poster.jpeg', fit: BoxFit.contain),
                          ),
                      ],
                    ),
                  ),
                  isDistance: true,
                  distanceTxt: Row(
                    children: [
                      Text("1.2km"),
                      Text("|"),
                      Text("부산해운대구중동")
                    ],
                  )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
