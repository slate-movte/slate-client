import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/errors/exceptions.dart';

import '../../../core/utils/apis.dart';

abstract class MarkerRemoteDataSource {
  Future<Set<Marker>> getMarkerLists(LatLng curLocation, String markerType);
}

Set<Marker> markerList = {};

class MarkerRemoteDataSourceImplementation implements MarkerRemoteDataSource {

  @override
  Future<Set<Marker>> getMarkerLists(LatLng curLocation, String markerType) async {
    try{

      final Uint8List markerIcon_movielocation =
      await getBytesFromAsset('lib/assets/images/movielocation_marker.png', 100);
      final Uint8List markerIcon_restaurant =
      await getBytesFromAsset('lib/assets/images/restaurant_marker.png', 100);
      Uint8List markerIcon_cafe =
      await getBytesFromAsset('lib/assets/images/cafe_marker.png', 100);
      final Uint8List markerIcon_accommodation =
      await getBytesFromAsset('lib/assets/images/accom.png', 200);

      final url = Uri.parse(
        MarkerAPI.markerURL(curLocation, markerType)
      );
      // var response = await http.get(url);
      // Map<List, dynamic> json =
      // jsonDecode(response.body) as Map<List, dynamic>;
      // MarkerModel.fromJson(json);
      // return List<MarkerModel>;

      //테스트 용도의 더미 데이터
      markerList = {
        Marker(
          markerId: const MarkerId("전주식당"),
          position: const LatLng(37.6313962, 127.0767797),
          // icon: BitmapDescriptor.fromBytes(markerIcon_restaurant),
          infoWindow: InfoWindow(
            title: "전주식당",
            snippet: "서울시~",
          ),
        ),
        Marker(
          markerId: const MarkerId("행복숙소"),
          position: const LatLng(37.63089, 127.0796858),
          // icon: BitmapDescriptor.fromBytes(markerIcon_accommodation),
          infoWindow: InfoWindow(
            title: "행복숙소",
            snippet: "대전~",
          ),
        )
      };

      return markerList;
    }catch(e) {
      throw ServerException();
    }
  }

  //마커 아이콘
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }


}