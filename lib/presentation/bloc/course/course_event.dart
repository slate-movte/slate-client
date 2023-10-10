import 'package:equatable/equatable.dart';

abstract class CourseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllCourseInfoEvent extends CourseEvent {}

class GetCourseInfoEvent extends CourseEvent {
  final int id;

  GetCourseInfoEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
