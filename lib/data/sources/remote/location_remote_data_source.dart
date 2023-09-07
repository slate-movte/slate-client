import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as Location;
import 'package:permission_handler/permission_handler.dart';

import '../../../core/errors/exceptions.dart';

abstract class LocationRemoteDataSource {
  Future<LatLng> getCurrentLocation();
}

class LocationRemoteDataSourceImplementation implements LocationRemoteDataSource {

  @override
  Future<LatLng> getCurrentLocation() async {

    if(await checkLocationPermissionStatus()){
      try {

        Location.LocationData position = await Location.Location().getLocation();

        return LatLng(position.latitude ?? 35.171585 ,position.longitude ?? 129.127796);


      } catch (e) {
        throw UnimplementedError();
      }
    }else{
      await Permission.location.request();
      return LatLng(35.171585 , 129.127796);
    }

  }


  @override
  Future<bool> checkLocationPermissionStatus() async {
    try {
      switch (await Permission.location.status) {
        case PermissionStatus.granted:
        case PermissionStatus.limited:
          return true;
        case PermissionStatus.restricted:
        case PermissionStatus.denied:
        case PermissionStatus.permanentlyDenied:
          return false;
        case PermissionStatus.provisional:
          return false;
      }
    } catch (e) {
      throw PermissionException();
    }
  }

}