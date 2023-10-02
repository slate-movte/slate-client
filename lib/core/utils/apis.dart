abstract class Api {
  static String hosts = "https://dev.movte.cloud/";
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

  static String scenesURL({required String title}) =>
      "${Api.hosts}scene?title=$title";
}

class CourseAPI implements APIS {
  static String courseAll() =>
      'https://dev.movte.cloud/course/all';

  static String courseInfo({required int id}) =>
      'https://dev.movte.cloud/course/$id';
}
