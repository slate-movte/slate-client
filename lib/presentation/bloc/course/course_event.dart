import 'package:equatable/equatable.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAllCourseEvent extends CourseEvent {

  UpdateAllCourseEvent();
}

class getInfoCourseEvent extends CourseEvent {
  final int id;

  getInfoCourseEvent({required this.id});
}
