import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

class LocationAndSensorEntity extends Equatable {
  const LocationAndSensorEntity({
    required this.location,
    required this.magnetometer,
  });

  final MagnetometerEntity magnetometer;
  final LocationData location;

  @override
  List<Object?> get props => <Object?>[magnetometer, location];
}

class MagnetometerEntity {
  MagnetometerEntity({required this.degree});
  final double degree;
}
