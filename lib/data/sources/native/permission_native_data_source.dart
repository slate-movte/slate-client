import 'package:permission_handler/permission_handler.dart';

import '../../../core/errors/exceptions.dart';

abstract class PermissionNativeDataSource {
  Future<bool> getLocationPermissionStatus();
  Future<void> setLocationPermission();
}

class PermissionNativeDataSourceImplementation implements PermissionNativeDataSource {

  @override
  Future<bool> getLocationPermissionStatus() async {
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

  Future<void> setLocationPermission() async {
    try {
      if (await getLocationPermissionStatus() ||
          await Permission.location.status ==
              PermissionStatus.permanentlyDenied) {
        openAppSettings();
      } else {
        await Permission.location.request();
      }
    } catch (e) {
      throw CacheException();
    }
  }

}