import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/themes.dart';
import '../bloc/course/course_bloc.dart';
import '../bloc/course/course_event.dart';
import '../bloc/course/course_state.dart';

class CourseContentsView extends StatefulWidget {
  final int courseId;
  const CourseContentsView({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  State<CourseContentsView> createState() => _CourseContentsViewState();
}

class _CourseContentsViewState extends State<CourseContentsView> {
  int _currentPage = 0;

  @override
  void initState() {
    context.read<CourseBloc>().add(GetCourseInfoEvent(id: widget.courseId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is CourseLoaded) {
            return Stack(
              children: [
                PageView.builder(
                  itemCount: state.course.courseImages.length,
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: ColorOf.black.light,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.network(
                          state.course.courseImages[index].imageUrl,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  height: Scaffold.of(context).appBarMaxHeight,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  width: double.infinity,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: ColorOf.white.light,
                        ),
                        iconSize: 25.w,
                      ),
                      Visibility(
                        visible: _currentPage != 0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 135.w),
                          child: Text(
                            "$_currentPage / ${state.course.courseImages.length - 1}",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: ColorOf.white.light),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container();
          // return const Center(
          //   child: CircularProgressIndicator(),
          // );
        },
      ),
    );
  }
}
