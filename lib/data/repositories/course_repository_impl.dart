import 'package:dartz/dartz.dart';
import 'package:slate/core/errors/failures.dart';

import '../../domain/repositories/course_repository.dart';
import '../sources/remote/course_api_remote_data_source.dart';

class CourseRepositoryImpl implements CourseRepository {
  CourseApiRemoteDataSource dataSource;

  CourseRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List>> getCourseAllResults() async {
    try {
      List result = await dataSource.getCourseAllResult();
      return Right(result);
    } on Exception {
      return Left(CourseFailure());
    }
  }

  @override
  Future<Either<Failure, List>> getCourseInfoResults(int id) async {
    try {
      List result = await dataSource.getCourseInfoResult(id);
      print("코스여기" + result.toString());
      return Right(result);
    } on Exception {
      return Left(CourseFailure());
    }
  }

}

