import 'dart:convert';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/errors/exceptions.dart';
import 'package:slate/core/utils/enums.dart';
import 'package:slate/data/models/map_marker_model.dart';
import 'package:http/http.dart' as http;
import 'package:slate/core/utils/apis.dart';

abstract class MapRemoteDataSource {
  Future<CameraPosition> getCameraPosition(LatLng latLng);
  Future<Set<MapItemModel>> getMarkersWithMapAPI(
    LatLng latLng,
    TravelType type,
    int cameraRange
  );
}

class MapRemoteDataSourceImpl implements MapRemoteDataSource {
  @override
  Future<CameraPosition> getCameraPosition(LatLng latLng) async {
    try {
      CameraPosition cameraPosition = CameraPosition(
        target: latLng,
        zoom: 15, //기본 15로 설정해둔 상태
      );
      return cameraPosition;
    } catch (e) {
      throw MapException();
    }
  }

  @override
  Future<Set<MapItemModel>> getMarkersWithMapAPI(
    LatLng latLng,
    TravelType type,
    int cameraRange
  ) async {
    try {
      // http 통신
      var url = Uri.parse(MarkerAPI.markerInfoURL(latlng: latLng, locationType: type.convertedText, range: cameraRange));
      var response = await http.get(url);

      Set<MapItemModel> markers = {};

      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
        //print("마커정보 : "+json['data'].toString());

        for(int i=0; i<json.length; i++){
          MapItemModel mapItemModel = MapItemModel.fromJson(
            Map<String, dynamic>.from(json['data'][i]),
          );

          markers.add(mapItemModel);
        }

        return markers;

      } else {
        throw HttpException(response.statusCode.toString());
      }

    } catch (e) {
      throw MapException();
    }
  }
}
