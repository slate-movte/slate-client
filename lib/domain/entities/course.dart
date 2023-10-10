import 'package:equatable/equatable.dart';

class Course extends Equatable {
  final int id;
  final String title;
  final String subTitle;
  final String thumbnail;
  final List<CourseContent> courseImages;

  const Course({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.thumbnail,
    this.courseImages = const [],
  });

  @override
  List<Object?> get props => [id];
}

class CourseContent extends Equatable {
  final int courseId;
  final String imageUrl;
  final int order;

  const CourseContent({
    required this.courseId,
    required this.imageUrl,
    required this.order,
  });

  @override
  List<Object?> get props => [courseId];
}
