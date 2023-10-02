import 'package:dartz/dartz.dart';
import 'package:slate/core/errors/failures.dart';
import 'package:slate/core/usecases/usecase.dart';
import '../repositories/course_repository.dart';

abstract class CourseUseCase {
  CourseRepository repository;

  CourseUseCase({required this.repository});
}

class AllCourse extends CourseUseCase
    implements UseCase<List, NoParams> {
  AllCourse({required super.repository});

  @override
  Future<Either<Failure, List>> call(NoParams params) async {
    return await super.repository.getCourseAllResults();
  }
}

class InfoCourse extends CourseUseCase
    implements UseCase<List, int> {
  InfoCourse({required super.repository});

  @override
  Future<Either<Failure, List>> call(int params) async {
    return await super.repository.getCourseInfoResults(params);
  }
}
