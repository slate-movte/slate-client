import '../../domain/entities/course.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.title,
    required super.subTitle,
    required super.thumbnail,
    super.courseImages,
  });

  factory CourseModel.getAllContents(Map<String, dynamic> json) {
    return CourseModel(
      id: json['courseId'] as int,
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      thumbnail: json['thumbnailImageUrl'] as String,
    );
  }

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['courseId'] as int,
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      thumbnail: json['thumbnailImageUrl'] as String,
      courseImages:
          List<Map<String, dynamic>>.from(json['courseImageResponses'])
              .map(
                (data) => CourseContentModel.fromJson(
                  json['courseId'] as int,
                  data['imageUrl'] as String,
                  data['order'] as int,
                ),
              )
              .toList(),
    );
  }
}

class CourseContentModel extends CourseContent {
  const CourseContentModel({
    required super.courseId,
    required super.imageUrl,
    required super.order,
  });

  factory CourseContentModel.fromJson(int id, String imageurl, int order) {
    return CourseContentModel(
      courseId: id,
      imageUrl: imageurl,
      order: order,
    );
  }
}
