import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/course.dart';

abstract class CourseRepository {
  Future<Either<Failure, List<Course>>> getCourseAllResults();
  Future<Either<Failure, Course>> getCourseInfoResults(int id);
}
