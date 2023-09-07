import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:slate/injection.dart';

import '../../../core/errors/exceptions.dart';

abstract class LocationRemoteDataSource {
  Future<LatLng> getCurrentLocation();
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  LocationRemoteDataSourceImpl();

  @override
  Future<LatLng> getCurrentLocation() async {
    LatLng latLng = const LatLng(35.171585, 129.127796);

    try {
      if (await _checkPermissionStatus()) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        LatLng temp = LatLng(
          position.latitude,
          position.longitude,
        );

        if (_checkBoundedPosition(temp)) {
          latLng = temp;
        }
      } else {
        await Permission.location.request();
      }
    } catch (e) {
      return latLng;
    }

    return latLng;
  }

  bool _checkBoundedPosition(LatLng latLng) {
    LatLngBounds bounds = DI(instanceName: CORE_LATLNG_BOUNDS);
    if (latLng.latitude >= bounds.southwest.latitude &&
        latLng.latitude <= bounds.northeast.latitude &&
        latLng.longitude >= bounds.southwest.longitude &&
        latLng.longitude <= bounds.northeast.longitude) {
      return true;
    }
    return false;
  }

  Future<bool> _checkPermissionStatus() async {
    try {
      switch (await Permission.location.status) {
        case PermissionStatus.granted:
        case PermissionStatus.limited:
        case PermissionStatus.provisional:
          return true;
        case PermissionStatus.denied:
        case PermissionStatus.restricted:
        case PermissionStatus.permanentlyDenied:
          return false;
      }
    } catch (e) {
      throw PermissionException();
    }
  }
}
