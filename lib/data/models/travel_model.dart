import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/utils/enums.dart';
import 'package:slate/domain/entities/travel.dart';

class TravelModel extends Travel {
  TravelModel({
    required super.id,
    required super.title,
    required super.images,
    required super.type,
    required super.location,
    super.menus,
    super.sceneLocation,
    super.imageUrl,
    required super.address,
  });

  factory TravelModel.fromJson(Map<String, dynamic> json) {
    return TravelModel(
      id: json['id'],
      title: json['title'],
      images: List<String>.from(json['images']),
      location: LatLng(json['latitude'] ?? 0, json['longitude'] ?? 0),
      menus: List<String>.from(json['menus']),
      type: TravelType.values.byName(json['type']),
      address: json['location']['address'],
    );
  }
}

class RestaurantModel extends Restaurant {
  RestaurantModel({
    required super.id,
    required super.title,
    required super.images,
    required super.location,
    required super.menus,
    required super.tel,
    required super.homepage,
    required super.overview,
    required super.openTime,
    required super.restDate,
    required super.address,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      title: json['title'],
      images: List<String>.from(json['images']),
      location: LatLng(json['latitude'] ?? 0, json['longitude'] ?? 0),
      menus: List<String>.from(json['menus']),
      tel: json['tel'],
      homepage: json['homepage'],
      overview: json['overview'],
      openTime: json['openTime'],
      restDate: json['restDate'],
      address: json['location']['address'],
    );
  }
}

class AccommodationModel extends Accommodation {
  AccommodationModel({
    required super.id,
    required super.title,
    required super.images,
    required super.location,
    required super.homepage,
    required super.overview,
    required super.tel,
    required super.address,
  });

  factory AccommodationModel.fromJson(Map<String, dynamic> json) {
    return AccommodationModel(
      id: json['id'],
      title: json['title'],
      images: List<String>.from(json['images']),
      location: LatLng(json['latitude'] ?? 0, json['longitude'] ?? 0),
      homepage: json['homepage'],
      overview: json['overview'],
      tel: json['tel'],
      address: json['location']['address'],
    );
  }
}

class AttractionModel extends Attraction {
  AttractionModel({
    required super.id,
    required super.title,
    required super.images,
    required super.location,
    required super.tel,
    required super.homepage,
    required super.overview,
    required super.openTime,
    required super.restDate,
    required super.address,
  });

  factory AttractionModel.fromJson(Map<String, dynamic> json) {

    return AttractionModel(
      id: json['id'],
      title: json['title'],
      images: List<String>.from(json['images']),
      location: LatLng(json['latitude'] ?? 0, json['longitude'] ?? 0),
      homepage: json['homepage'],
      overview: json['overview'],
      tel: json['tel'],
      openTime: json['openTime'],
      restDate: json['restDate'],
      address: json['location']['address'],
    );
  }
}

class MovieLocationModel extends MovieLocation {
  MovieLocationModel({
    required super.id,
    required super.title,
    required super.sceneLocation,
    required super.imageUrl,
    required super.location,
    required super.movieId,
    required super.address,
  });

  factory MovieLocationModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> location = json['location'];

    return MovieLocationModel(
      id: json['sceneId'],
      title: json['movie']['title'],
      imageUrl: json['imageUrl'],
      sceneLocation: json['sceneLocation'],
      location: LatLng((location['latitude'] ?? 0.0 ) as double, (location['longitude'] ?? 0.0 ) as double),
      movieId: json['movie']['movieId'],
      address: location['address'],
    );
  }
}
