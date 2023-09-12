import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/data/models/movie_model.dart';
import 'package:slate/data/sources/remote/search_api_remote_data_source.dart';
import 'package:slate/domain/entities/travel.dart';

import '../../core/utils/assets.dart';

class CourseView extends StatefulWidget {
  const CourseView({super.key});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  (List<MovieModel>, List<Travel>) result = ([], []);
  SearchApiRemoteDataSource dataSource = SearchApiRemoteDataSourceImpl();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image.asset(
        //   Images.APP_LOGO.path,
        //   width: 150.w,
        //   height: 100.h,
        // ),
        // Text("곧 공개될 페이지입니다."),

        Flexible(
          flex: 1,
          child: ListView(
            children: result.$1.map((movie) => Text(movie.title)).toList(),
          ),
        ),
        Flexible(
          flex: 1,
          child: ListView(
            children: result.$2.map((travel) => Text(travel.title)).toList(),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            result = await dataSource.getSearchResultsWithKeyword("", 1, 1);
            setState(() {});

            print(result);
          },
          child: Text('dddd'),
        ),
      ],
    ));
  }
}
