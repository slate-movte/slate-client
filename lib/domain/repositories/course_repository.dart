import 'package:dartz/dartz.dart';
import 'package:slate/core/errors/failures.dart';

abstract class CourseRepository {

  Future<Either<Failure, List>> getCourseAllResults();
  Future<Either<Failure, List>> getCourseInfoResults(int id);

}
