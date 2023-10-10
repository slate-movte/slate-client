import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/themes.dart';
import '../bloc/course/course_bloc.dart';
import '../bloc/course/course_event.dart';
import '../bloc/course/course_state.dart';

class CourseContentsView extends StatefulWidget {
  final int courseId;
  const CourseContentsView({Key? key, required this.courseId})
      : super(key: key);

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: SizeOf.w_lg,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      extendBodyBehindAppBar: true,
      body: BlocConsumer<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is InfoCourseLoaded) {
            return PageView.builder(
              itemCount: state.info.length,
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
                  child: Column(
                    children: [
                      Visibility(
                        visible: index != 0 ? true : false,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: Scaffold.of(context).appBarMaxHeight,
                              width: double.infinity,
                              color: ColorOf.black.light,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: Scaffold.of(context).appBarMaxHeight! /
                                        1.6),
                                child: Text(
                                  "$_currentPage / ${state.info.length - 1}",
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
                      Container(
                        width: double.infinity,
                        height: index != 0
                            ? MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top
                            : MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: index != 0 ? BoxFit.fitWidth : BoxFit.cover,
                            image: NetworkImage(state.info[index]['imageUrl']),
                          ),
                        ),
                        child: Container(),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}
