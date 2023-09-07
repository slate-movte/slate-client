import 'package:slate/domain/entities/travel.dart';

class RestaurantModel extends Restaurant {
  RestaurantModel({
    required super.id,
    required super.title,
    required super.images,
    required super.location,
  });
}

class AccommodationModel extends Accommodation {
  AccommodationModel({
    required super.id,
    required super.title,
    required super.images,
    required super.location,
  });
}

class AttractionModel extends Attraction {
  AttractionModel({
    required super.id,
    required super.title,
    required super.images,
    required super.location,
  });
}
