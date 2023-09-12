import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/utils/enums.dart';
import 'package:slate/domain/entities/travel.dart';

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

class TravelModel extends Travel {
  TravelModel({
    required super.id,
    required super.title,
    required super.images,
    required super.type,
    required super.location,
    super.menus,
  });

  factory TravelModel.fromJson(Map<String, dynamic> json) {
    return TravelModel(
      id: json['id'],
      title: json['title'],
      images: List<String>.from(json['images']),
      location: LatLng(json['latitude'] ?? 0, json['longitude'] ?? 0),
      menus: List<String>.from(json['menus']),
      type: TravelType.values.byName(json['type']),
    );
  }
}

class RestaurantModel extends Restaurant {
  RestaurantModel({
    required super.id,
    required super.title,
    required super.images,
    required super.location,
    super.menus,
    super.tel,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      title: json['title'],
      images: json['images'],
      location: LatLng(json['latitude'], json['longitude']),
      menus: json['menus'],
    );
  }
}

class AccommodationModel extends Accommodation {
  AccommodationModel({
    required super.id,
    required super.title,
    required super.images,
    required super.location,
  });

  factory AccommodationModel.fromJson(Map<String, dynamic> json) {
    return AccommodationModel(
      id: json['id'],
      title: json['title'],
      images: json['images'],
      location: LatLng(json['latitude'], json['longitude']),
    );
  }
}

class AttractionModel extends Attraction {
  AttractionModel({
    required super.id,
    required super.title,
    required super.images,
    required super.location,
  });
}
