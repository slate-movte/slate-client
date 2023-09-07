import 'package:equatable/equatable.dart';

class Location extends Equatable {
  String address;
  String longitude;
  String latitude;

  Location({
    required this.address,
    required this.longitude,
    required this.latitude,
  });

  @override
  List<Object?> get props => [longitude, latitude];
}
