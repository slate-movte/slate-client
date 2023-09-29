import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/assets.dart';
import '../../core/utils/themes.dart';
import 'course_thumbnail_view.dart';

class CourseView extends StatefulWidget {
  const CourseView({super.key});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: SizeOf.w_lg,
        title: Image.asset(
          Images.APP_LOGO.path,
          fit: BoxFit.contain,
          height: 32.h,
        ),
      ),
      body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   padding: EdgeInsets.only(bottom: SizeOf.h_sm, left: SizeOf.w_lg),
              //   width: double.infinity,
              //   child:
              //   Text(
              //     '추천코스',
              //     style: Theme.of(context).textTheme.titleLarge,
              //     textAlign: TextAlign.start,
              //   ),
              // ),
              contentBox(Images.COURSE_IMG.path, "A촬영지 근처 코스", "영화로 둘러 보는 부산"),
              contentBox(Images.COURSE_IMG.path, "동래구", "비오는 날: 이 영화 기억나?"),
              ],
          ),
              // Image.asset(
              //   Images.APP_LOGO.path,
              //   width: 150.w,
              //   height: 100.h,
              // ),
              // Text("곧 공개될 페이지입니다."),
    );
  }

  Widget contentBox(String imagePath, String subTitle, String mainTitle){
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseThumbnailView(subTitle: subTitle, mainTitle : mainTitle),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 197.h,
              width: 350.w,
              fit: BoxFit.cover,
            ),
            Container(
              color: ColorOf.black.light,
              height: 85.h,
              width: 350.w,
              padding: EdgeInsets.only(top: SizeOf.h_md, bottom: SizeOf.h_sm, left: SizeOf.w_md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subTitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(
                      color: ColorOf.white.light,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(mainTitle,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .apply(
                      color: ColorOf.white.light,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.h
            )
          ],
        ),
      ),
    );
  }
}
