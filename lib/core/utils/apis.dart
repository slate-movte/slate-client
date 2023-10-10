import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class Api {
  static String hosts = "https://dev.movte.cloudfdfdfdfdf/";
}

class SearchAPI extends Api {
  static String keywordURL({
    required String keyword,
    required int movieLastId,
    required int attractionLastId,
  }) =>
      "${Api.hosts}search?keyword=$keyword&movieLastId=$movieLastId&attractionLastId=$attractionLastId";

  static String movieInfoURL({required int id}) =>
      "${Api.hosts}search/movie/$id";

  static String restaurantInfoURL({required int id}) =>
      "${Api.hosts}search/restaurant/$id";
  static String accommodationInfoURL({required int id}) =>
      "${Api.hosts}search/accommodation/$id";
  static String attractionInfoURL({required int id}) =>
      "${Api.hosts}search/attraction/$id";
  static String movieLocationInfoURL({required int id}) =>
      "${Api.hosts}search/scene/$id";
}

class CourseAPI implements Api {
  static String courseAll() => '${Api.hosts}course/all';

  static String courseInfo({required int id}) => '${Api.hosts}course/$id';
}

class SceneApi implements Api {
  static String scenesURL({required String title}) =>
      "${Api.hosts}scene?title=$title";
}

class MarkerAPI extends Api {
  static String markerInfoURL(
          {required LatLng latlng,
          required String locationType,
          required int range}) =>
      "${Api.hosts}map/search?latitude=${latlng.latitude}&longitude=${latlng.longitude}&locationType=$locationType&range=$range";
}
