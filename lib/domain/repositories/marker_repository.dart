import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/errors/failures.dart';

abstract class MarkerRepository {

  Future<Either<Failure, Set<Marker>>> getMarkerLists(String movieType);

}
