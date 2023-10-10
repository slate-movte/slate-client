import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/assets.dart';
import '../../core/utils/themes.dart';
import '../../domain/entities/course.dart';
import '../bloc/course/course_bloc.dart';
import '../bloc/course/course_event.dart';
import '../bloc/course/course_state.dart';
import 'course_contents_view.dart';

class CourseView extends StatefulWidget {
  const CourseView({super.key});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  List<Course> courses = [];

  @override
  void initState() {
    context.read<CourseBloc>().add(GetAllCourseInfoEvent());
    super.initState();
  }

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
      body: BlocConsumer<CourseBloc, CourseState>(
        listener: (context, state) {
          if (state is AllCourseLoaded) {
            setState(() {
              courses = state.courses;
            });
          }
        },
        builder: (context, state) {
          if (state is InitCourse) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CourseError) {
            return Center(
              child: Text(state.message),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return contentBox(
                courses[index].id,
                courses[index].thumbnail,
                courses[index].subTitle,
                courses[index].title,
              );
            },
            itemCount: courses.length,
          );
        },
      ),
    );
  }

  Widget contentBox(
    int courseId,
    String imagePath,
    String subTitle,
    String mainTitle,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseContentsView(courseId: courseId),
          ),
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 24.h,
            ),
            Image.network(
              imagePath,
              height: 197.h,
              width: 350.w,
              fit: BoxFit.cover,
            ),
            Container(
              color: ColorOf.black.light,
              height: 85.h,
              width: 350.w,
              padding: EdgeInsets.only(
                  top: SizeOf.h_md, bottom: SizeOf.h_sm, left: SizeOf.w_md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subTitle,
                    style: Theme.of(context).textTheme.bodySmall!.apply(
                          color: ColorOf.white.light,
                        ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    mainTitle,
                    style: Theme.of(context).textTheme.titleMedium!.apply(
                          color: ColorOf.white.light,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
