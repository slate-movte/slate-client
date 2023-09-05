import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

abstract class LocationRemoteDataSource {
  Future<LatLng> getCurrentLocation();
}

class LocationRemoteDataSourceImplementation implements LocationRemoteDataSource {

  @override
  Future<LatLng> getCurrentLocation() async {

    try {
      //현재 사용자 위치 기반
      LocationData position = await Location().getLocation();

      return LatLng(position.latitude ?? 35.171585 ,position.longitude ?? 129.127796);

    } catch (e) {
      throw UnimplementedError();
    }
  }

}