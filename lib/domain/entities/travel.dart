import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/utils/enums.dart';

abstract class Travel extends Equatable {
  final int id;
  final String title;
  final String? tel;
  final List<String> images;
  final String? homepage;
  final String? overview;
  final TravelType type;
  final LatLng location;

  const Travel({
    required this.id,
    required this.title,
    required this.images,
    required this.type,
    required this.location,
    this.tel,
    this.homepage,
    this.overview,
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
    super.type = TravelType.ATTRACTION,
    this.openTime,
    this.restDate,
  });
}

class Restaurant extends Travel {
  final String? treatMenu;
  final String? openTime;
  final String? restDate;

  const Restaurant({
    required super.id,
    required super.title,
    required super.images,
    required super.location,
    super.type = TravelType.RESTAURANT,
    this.treatMenu,
    this.openTime,
    this.restDate,
  });
}

class Accommodation extends Travel {
  const Accommodation({
    required super.id,
    required super.title,
    required super.images,
    required super.location,
    super.type = TravelType.ACCOMMODATION,
  });
}
