import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/utils/enums.dart';
import 'package:slate/domain/entities/map_item.dart';

class MapItemModel extends MapItem {
  const MapItemModel({
    required super.markerId,
    required super.type,
    required super.title,
    required super.position,
  });

  factory MapItemModel.fromJson(Map<String, dynamic> json) {
    MarkerId markId = MarkerId(json['info']['id'].toString());
    LatLng markPosition = LatLng(json['location']['latitude'], json['location']['longitude']);

    String travelType = json['info']['type'];

    MapItemModel mapItemModel = MapItemModel(
      markerId: markId,
      type: travelType.convertedType,
      title: json['info']['title'].toString(),
      position: markPosition,
    );

    return mapItemModel;
  }
}