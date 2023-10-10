import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../core/errors/exceptions.dart';
import '../../../core/utils/apis.dart';

abstract class CourseApiRemoteDataSource {
  Future<List> getCourseAllResult();
  Future<List> getCourseInfoResult(int id);
}

class CourseApiRemoteDataSourceImpl implements CourseApiRemoteDataSource {
  @override
  Future<List> getCourseAllResult() async {
    try {
      var url = Uri.parse(CourseAPI.courseAll());

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

        // print("코스" + json['data'][0].toString());

        return json['data'];
      } else {
        throw HttpException(response.statusCode.toString());
      }
    } catch (e) {
      throw ApiException();
    }
  }

  @override
  Future<List> getCourseInfoResult(int id) async {
    try {
      var url = Uri.parse(CourseAPI.courseInfo(id: id));

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

        //print("코스" + json['data']['courseImageResponses'].toString());

        return json['data']['courseImageResponses'];
      } else {
        throw HttpException(response.statusCode.toString());
      }
    } catch (e) {
      throw ApiException();
    }
  }
}
