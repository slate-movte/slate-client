import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../core/errors/exceptions.dart';
import '../../../core/utils/apis.dart';
import '../../models/course_model.dart';

abstract class CourseApiRemoteDataSource {
  Future<List<CourseModel>> getCourseAllResult();
  Future<CourseModel> getCourseInfoResult(int id);
}

class CourseApiRemoteDataSourceImpl implements CourseApiRemoteDataSource {
  @override
  Future<List<CourseModel>> getCourseAllResult() async {
    try {
      var url = Uri.parse(CourseAPI.courseAll());

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

        return List<Map<String, dynamic>>.from(json['data'])
            .map((course) => CourseModel.getAllContents(course))
            .toList();
      } else {
        throw HttpException(response.statusCode.toString());
      }
    } catch (e) {
      throw ApiException();
    }
  }

  @override
  Future<CourseModel> getCourseInfoResult(int id) async {
    try {
      var url = Uri.parse(CourseAPI.courseInfo(id: id));

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

        return CourseModel.fromJson(json['data']);
      } else {
        throw HttpException(response.statusCode.toString());
      }
    } catch (e) {
      throw ApiException();
    }
  }
}
