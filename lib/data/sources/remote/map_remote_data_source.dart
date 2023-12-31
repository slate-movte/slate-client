import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/utils/apis.dart';
import '../../../core/utils/enums.dart';
import '../../models/map_marker_model.dart';

abstract class MapRemoteDataSource {
  Future<CameraPosition> getCameraPosition(LatLng latLng);
  Future<List<MapItemModel>> getMarkersWithMapAPI(
    LatLng latLng,
    TravelType type,
    int range,
  );
}

class MapRemoteDataSourceImpl implements MapRemoteDataSource {
  @override
  Future<CameraPosition> getCameraPosition(LatLng latLng) async {
    try {
      CameraPosition cameraPosition = CameraPosition(
        target: latLng,
        zoom: 15,
      );
      return cameraPosition;
    } catch (e) {
      throw MapException();
    }
  }

  @override
  Future<List<MapItemModel>> getMarkersWithMapAPI(
      LatLng latLng, TravelType type, int cameraRange) async {
    try {
      cameraRange = 2; //구글맵 카메라 확대 범위 임의 설정

      log("타겟 타입 : $type");
      log("API URL : ${MarkerAPI.markerInfoURL(
        latlng: latLng,
        locationType: type.name,
        range: cameraRange,
      )}");

      var url = Uri.parse(MarkerAPI.markerInfoURL(
        latlng: latLng,
        locationType: type.name,
        range: cameraRange,
      ));
      var response = await http.get(url);

      List<MapItemModel> markers = [];
      log("temp 마커 : $markers");

      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
        log("--------------------------------------------------------");
        log("Json : $json");
        log("--------------------------------------------------------");

        for (int i = 0; i < json['data'].length; i++) {
          MapItemModel mapItemModel = MapItemModel.fromJson(
            Map<String, dynamic>.from(json['data'][i]),
          );

          markers.add(mapItemModel);
        }

        log('최종 마커 : $markers');

        return markers;
      } else {
        throw HttpException(response.statusCode.toString());
      }
    } catch (e) {
      throw MapException();
    }
  }
}
