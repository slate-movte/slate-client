import 'package:equatable/equatable.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAllCourseEvent extends CourseEvent {
  const UpdateAllCourseEvent();
}

class GetCourseInfoEvent extends CourseEvent {
  final int id;

  const GetCourseInfoEvent({required this.id});
}
