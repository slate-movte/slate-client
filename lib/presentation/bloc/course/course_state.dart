import 'package:equatable/equatable.dart';

class CourseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AllCourseLoaded extends CourseState {

  final List course;

  AllCourseLoaded({required this.course});

  @override
  List<Object?> get props => course;

}

class InfoCourseLoaded extends CourseState {

  final List info;

  InfoCourseLoaded({required this.info});

  @override
  List<Object?> get props => info;

}

class InitCourse extends CourseState {}

class CourseError extends CourseState {
  final String message;

  CourseError({required this.message});

  @override
  List<Object?> get props => [message];
}
