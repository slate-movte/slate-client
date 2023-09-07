import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerModel extends Marker {
  const MarkerModel({
    required super.markerId,
    // required super.locX,
    // required super.locY,
    // required super.locInfo,
  });

  factory MarkerModel.fromJson(Map<String, dynamic> json) {
    return MarkerModel(
      markerId: json['markerId'],
      // locX: json['loc_x'],
      // locY: json['loc_y'],
      // locInfo: json['loc_info'],
    );
  }

}