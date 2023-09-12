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

  static String movieInfoURL({required int id}) => "search/movie?id=$id";

  static String restaurantInfoURL({required int id}) => "search/restaurant/$id";
  static String accommodationInfoURL({required int id}) =>
      "search/accommodation/$id";
  static String attractionInfoURL({required int id}) => "search/attraction/$id";
}
