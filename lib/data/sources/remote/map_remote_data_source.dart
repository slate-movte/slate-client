import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/errors/exceptions.dart';
import 'package:slate/core/utils/enums.dart';
import 'package:slate/data/models/map_marker_model.dart';

abstract class MapRemoteDataSource {
  Future<CameraPosition> getCameraPosition(LatLng latLng);
  Future<Set<MapMarkerModel>> getMarkersWithMapAPI(
    LatLng latLng,
    TravelType type,
  );
}

class MapRemoteDataSourceImpl implements MapRemoteDataSource {
  @override
  Future<CameraPosition> getCameraPosition(LatLng latLng) async {
    try {
      CameraPosition cameraPosition = CameraPosition(
        target: latLng,
        zoom: 16,
      );
      return cameraPosition;
    } catch (e) {
      throw MapException();
    }
  }

  @override
  Future<Set<MapMarkerModel>> getMarkersWithMapAPI(
    LatLng latLng,
    TravelType type,
  ) async {
    try {
      // http 통신
      Set<MapMarkerModel> markers = {};
      markers.addAll({
        MapMarkerModel(
          markerId: MarkerId('0'),
          type: type,
          title: '전주식당',
          position: LatLng(37.6313962, 127.0767797),
        ),
        MapMarkerModel(
          markerId: MarkerId('1'),
          type: type,
          title: '전주식당2',
          position: LatLng(37.5313962, 127.0767797),
        )
      });
      return markers;
    } catch (e) {
      throw MapException();
    }
  }
}
