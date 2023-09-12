import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/utils/enums.dart';

/*
  "id": 10,
                "title": "범어사(부산)",
                "tel": "",
                "images": [
                    "http://tong.visitkorea.or.kr/cms/resource/72/1954572_image2_1.jpg",
                    "http://tong.visitkorea.or.kr/cms/resource/72/1954572_image3_1.jpg"
                ],
                "type": "ATTRACTION",
                "location": {
                    "address": "부산광역시 금정구 범어사로 250 (청룡동)",
                    "latitude": 35.2839975351,
                    "longitude": 129.0681263762
                },
                "menus": [
                    ""
                ]
*/

abstract class Travel extends Equatable {
  final int id;
  final String title;
  final String? tel;
  final List<String> images;
  final String? homepage;
  final String? overview;
  final TravelType type;
  final LatLng location;
  final List<String>? menus;

  const Travel({
    required this.id,
    required this.title,
    required this.images,
    required this.type,
    required this.location,
    this.menus,
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
    super.tel,
    super.homepage,
    super.overview,
    super.type = TravelType.ATTRACTION,
    this.openTime,
    this.restDate,
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
  });
}
