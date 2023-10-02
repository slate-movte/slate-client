import 'package:equatable/equatable.dart';

import 'course_content.dart';

class CourseItem extends Equatable {
  final int courseId;
  final String title;
  final String subTitle;
  final String thumbnailImageUrl;
  final List<CourseContent> courseImages;

  const CourseItem({
    required this.courseId,
    required this.title,
    required this.subTitle,
    required this.thumbnailImageUrl,
    this.courseImages = const [],
  });

  @override
  List<Object?> get props => [courseId];
}
