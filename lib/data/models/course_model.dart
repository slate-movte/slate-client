import 'dart:developer';
import '../../domain/entities/course.dart';

class CourseModel extends Course {
  CourseModel({
    required super.courseId,
    required super.title,
    required super.subTitle,
    required super.thumbnailImageUrl,
    super.courseImages,
  });

  factory CourseModel.getAllContentsApi(Map<String, dynamic> json) {
    return CourseModel(
      courseId: json['courseId'] as int,
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      thumbnailImageUrl: json['subTitle'] as String,
    );
  }

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    log('코스모델입력');
    return CourseModel(
      courseId: json['courseId'] as int,
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      thumbnailImageUrl: json['subTitle'] as String,
      courseImages:
          List<Map<String, dynamic>>.from(json['courseImageResponses'])
              .map(
                (data) => CourseContentModel.fromJson(
                    data, json['imageUrl'], json['order']),
              )
              .toList(),
    );
  }
}

class CourseContentModel extends CourseContent {
  CourseContentModel({
    required super.courseId,
    required super.imageUrl,
    required super.order,
  });

  factory CourseContentModel.fromJson(
      Map<String, dynamic> json, String imageurl, int order) {
    return CourseContentModel(
      courseId: json['courseId'] as int,
      imageUrl: imageurl,
      order: order,
    );
  }
}
