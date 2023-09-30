import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class APIS {}

class MarkerAPI implements APIS {
  static String markerURL(LatLng latlng, String markerType) =>
      'https://dev.movte.cloud/map/search?latitude=${latlng.latitude}&longtitude${latlng.longitude}&locationType=$markerType';
}

class CourseAPI implements APIS {
  static String courseAll() =>
      'https://dev.movte.cloud/course/all';

  static String courseInfo({required int id}) =>
      'https://dev.movte.cloud/course/$id';
}
