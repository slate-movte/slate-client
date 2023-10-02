import 'dart:convert';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/errors/exceptions.dart';
import 'package:slate/core/utils/enums.dart';
import 'package:slate/data/models/map_marker_model.dart';
import 'package:http/http.dart' as http;
import '../../../core/utils/apis.dart';

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
    LatLng latLng,
    TravelType type,
    int cameraRange
  ) async {
    try {
      // http 통신
      var url = Uri.parse(MarkerAPI.markerInfoURL(latlng: latLng, locationType: type.convertedText, range: cameraRange));
      var response = await http.get(url);

      List<MapItemModel> markers = [];

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

      switch (type) {
        case TravelType.RESTAURANT:
          markers.addAll({
            MapItemModel(
              markerId: MarkerId('0'),
              type: type,
              title: '유명한 횟집',
              position: LatLng(35.175435, 129.127167),
            ),
            MapItemModel(
              markerId: MarkerId('1'),
              type: type,
              title: '장박사양곱창',
              position: LatLng(35.174013, 129.128126),
            ),
          });
          break;

        case TravelType.ACCOMMODATION:
          markers.addAll({
            MapItemModel(
              markerId: MarkerId('2'),
              type: type,
              title: '부산 센텀 스위트호텔',
              position: LatLng(35.166799, 129.131943),
            ),
            MapItemModel(
              markerId: MarkerId('3'),
              type: type,
              title: '센텀컨벤션호텔',
              position: LatLng(35.168051, 129.133372),
            ),
          });
          break;

        case TravelType.ATTRACTION:
          markers.addAll({
            MapItemModel(
              markerId: MarkerId('4'),
              type: type,
              title: '벡스코',
              position: LatLng(35.170279, 129.134455),
            ),
            MapItemModel(
              markerId: MarkerId('5'),
              type: type,
              title: '좌수영교',
              position: LatLng(35.175094, 129.121465),
            ),
          });
          break;

        case TravelType.MOVIE_LOCATION:
          markers.addAll({
            MapItemModel(
              markerId: MarkerId('6'),
              type: type,
              title: '영화진흥위원회',
              position: LatLng(35.171809, 129.125496),
            ),
            MapItemModel(
              markerId: MarkerId('7'),
              type: type,
              title: '영화의 전당',
              position: LatLng(35.171660, 129.128028),
            ),
          });
          break;
      }

      return markers;
    } catch (e) {
      throw MapException();
    }
  }
}
