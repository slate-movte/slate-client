import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class APIS{}

class MarkerAPI implements APIS {
  static String markerURL(LatLng latlng, String markerType) =>
      'https://dev.movte.cloud/map/search?latitude=${latlng.latitude}&longtitude${latlng.longitude}&locationType=$markerType';
}