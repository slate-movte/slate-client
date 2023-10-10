import 'package:equatable/equatable.dart';

import '../../../domain/entities/course.dart';

class CourseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AllCourseLoaded extends CourseState {
  final List<Course> courses;

  AllCourseLoaded({required this.courses});

  @override
  List<Object?> get props => courses;
}

class CourseLoaded extends CourseState {
  final Course course;

  CourseLoaded({required this.course});

  @override
  List<Object?> get props => [course];
}

class InitCourse extends CourseState {}

class CourseError extends CourseState {
  final String message;

  CourseError({required this.message});

  @override
  List<Object?> get props => [message];
}
