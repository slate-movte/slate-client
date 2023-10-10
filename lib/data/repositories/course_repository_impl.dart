import 'package:dartz/dartz.dart';
import 'package:slate/core/errors/failures.dart';

import '../../domain/entities/course.dart';
import '../../domain/repositories/course_repository.dart';
import '../sources/remote/course_api_remote_data_source.dart';

class CourseRepositoryImpl implements CourseRepository {
  CourseApiRemoteDataSource dataSource;

  CourseRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Course>>> getCourseAllResults() async {
    try {
      final result = await dataSource.getCourseAllResult();
      return Right(result);
    } on Exception {
      return Left(CourseFailure());
    }
  }

  @override
  Future<Either<Failure, Course>> getCourseInfoResults(int id) async {
    try {
      final result = await dataSource.getCourseInfoResult(id);
      return Right(result);
    } on Exception {
      return Left(CourseFailure());
    }
  }
}
