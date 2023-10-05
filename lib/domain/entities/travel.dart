import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/utils/enums.dart';

class Travel extends Equatable {
  final int id;
  final String title;
  final String? tel;
  final List<String>? images;
  final String? homepage;
  final String? overview;
  final TravelType type;
  final LatLng location;
  final String address;
  final List<String>? menus;
  final String? imageUrl;
  final String? sceneLocation;
  final int? movieId;
  final String? openTime;

  const Travel({
    required this.id,
    required this.title,
    this.images,
    required this.type,
    required this.location,
    required this.address,
    this.imageUrl,
    this.menus,
    this.tel,
    this.homepage,
    this.overview,
    this.sceneLocation,
    this.movieId,
    this.openTime,
  });

  @override
  List<Object?> get props => [id];
}

class Attraction extends Travel {
  final String? openTime;
  final String? restDate;

  const Attraction({
    required super.id,
    required super.title,
    required super.images,
    required super.location,
    super.tel,
    super.homepage,
    super.overview,
    super.type = TravelType.ATTRACTION,
    this.openTime,
    this.restDate,
    required super.address,
  });
}

class Restaurant extends Travel {
  final String? openTime;
  final String? restDate;

  const Restaurant({
    required super.id,
    required super.title,
    required super.images,
    required super.location,
    super.type = TravelType.RESTAURANT,
    super.menus = const [],
    this.openTime,
    this.restDate,
    super.homepage,
    super.overview,
    super.tel,
    required super.address,
  });
}

class Accommodation extends Travel {
  const Accommodation({
    required super.id,
    required super.title,
    required super.images,
    required super.location,
    super.type = TravelType.ACCOMMODATION,
    super.homepage,
    super.overview,
    super.tel,
    required super.address,
  });
}

class MovieLocation extends Travel {
  const MovieLocation({
    required super.id,
    required super.title,
    required super.sceneLocation,
    required super.imageUrl,
    required super.location,
    required super.movieId,
    super.type = TravelType.MOVIE_LOCATION,
    required super.address,
  });
}
