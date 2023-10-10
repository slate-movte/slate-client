import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/usecases/usecase.dart';
import '../../../domain/usecases/course_usecase.dart';
import 'course_event.dart';
import 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  AllCourse allCourse;
  InfoCourse infoCourse;

  CourseBloc({
    required this.allCourse,
    required this.infoCourse,
  }) : super(InitCourse()) {
    on<UpdateAllCourseEvent>(_getAllCourseEvent);
    on<GetCourseInfoEvent>(_getInfoCourseEvent);
  }

  Future _getAllCourseEvent(
    UpdateAllCourseEvent event,
    Emitter<CourseState> emit,
  ) async {
    emit(InitCourse());
    final result = await allCourse(NoParams());
    result.fold((failure) {
      emit(CourseError(message: '추천 코스 정보가 없습니다.'));
    }, (result) {
      emit(AllCourseLoaded(course: result));
    });
  }

  Future _getInfoCourseEvent(
    GetCourseInfoEvent event,
    Emitter<CourseState> emit,
  ) async {
    emit(InitCourse());
    final result = await infoCourse(event.id);
    result.fold((failure) {
      emit(CourseError(message: '추천 코스 정보가 없습니다.'));
    }, (result) {
      emit(InfoCourseLoaded(info: result));
    });
  }
}
