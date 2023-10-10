import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/usecases/usecase.dart';
import '../../../domain/usecases/course_usecase.dart';
import 'course_event.dart';
import 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  GetAllCourseInfo getAllCourseInfo;
  GetCourseWithId getCourseWithId;

  CourseBloc({
    required this.getAllCourseInfo,
    required this.getCourseWithId,
  }) : super(InitCourse()) {
    on<GetAllCourseInfoEvent>(_getAllCourseEvent);
    on<GetCourseInfoEvent>(_getInfoCourseEvent);
  }

  Future _getAllCourseEvent(
    GetAllCourseInfoEvent event,
    Emitter<CourseState> emit,
  ) async {
    emit(InitCourse());
    final result = await getAllCourseInfo(NoParams());
    result.fold(
      (failure) {
        emit(CourseError(message: '추천 코스 정보가 없습니다.'));
      },
      (result) {
        emit(AllCourseLoaded(courses: result));
      },
    );
  }

  Future _getInfoCourseEvent(
    GetCourseInfoEvent event,
    Emitter<CourseState> emit,
  ) async {
    emit(InitCourse());
    final result = await getCourseWithId(event.id);
    result.fold((failure) {
      emit(CourseError(message: '추천 코스 정보가 없습니다.'));
    }, (result) {
      emit(CourseLoaded(course: result));
    });
  }
}
