import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/course.dart';
import '../repositories/course_repository.dart';

abstract class CourseUseCase {
  CourseRepository repository;

  CourseUseCase({required this.repository});
}

class GetAllCourseInfo extends CourseUseCase
    implements UseCase<List<Course>, NoParams> {
  GetAllCourseInfo({required super.repository});

  @override
  Future<Either<Failure, List<Course>>> call(NoParams params) async {
    return await super.repository.getCourseAllResults();
  }
}

class GetCourseWithId extends CourseUseCase implements UseCase<Course, int> {
  GetCourseWithId({required super.repository});

  @override
  Future<Either<Failure, Course>> call(int params) async {
    return await super.repository.getCourseInfoResults(params);
  }
}
