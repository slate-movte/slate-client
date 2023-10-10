import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/utils/enums.dart';
import '../../domain/entities/map_item.dart';

class MapItemModel extends MapItem {
  const MapItemModel({
    required super.markerId,
    required super.type,
    required super.title,
    required super.position,
  });

  factory MapItemModel.fromJson(Map<String, dynamic> json) {
    MarkerId markId = MarkerId(json['info']['id'].toString());
    LatLng markPosition =
        LatLng(json['location']['latitude'], json['location']['longitude']);

    String travelType = json['info']['type'];

    MapItemModel mapItemModel = MapItemModel(
      markerId: markId,
      type: TravelType.values.firstWhere(
        (type) => type.name == travelType,
        orElse: () => TravelType.MOVIE_LOCATION,
      ),
      title: json['info']['title'].toString(),
      position: markPosition,
    );

    return mapItemModel;
  }
}
