enum TravelType {
  RESTAURANT,
  ACCOMMODATION,
  ATTRACTION,
  MOVIE_LOCATION,
}

extension MarkerExtension1 on TravelType {
  String get convertedText {
    switch (this) {
      case TravelType.RESTAURANT:
        return "RESTAURANT";
      case TravelType.ACCOMMODATION:
        return "ACCOMMODATION";
      case TravelType.ATTRACTION:
        return "ATTRACTION";
      case TravelType.MOVIE_LOCATION:
        return "MOVIE_LOCATION";
      default:
        return "";
    }
  }
}

extension MarkerExtension2 on String {
  TravelType get convertedType {
    switch (this) {
      case "RESTAURANT":
        return TravelType.RESTAURANT;
      case "ACCOMMODATION":
        return TravelType.ACCOMMODATION;
      case "ATTRACTION":
        return TravelType.ATTRACTION;
      case "MOVIE_LOCATION":
        return TravelType.MOVIE_LOCATION;
      default:
        return TravelType.MOVIE_LOCATION; //default를 영화촬영지로 설정해도 될지
    }
  }
}