import 'package:quickdrop_delivery/src/features/location/domain/entity/location_and_sensor_entity.dart';

class LocationAndSensorModel extends LocationAndSensorEntity {
  const LocationAndSensorModel({
    required super.location,
    required super.magnetometer,
  });
}

class MagnetometerModel extends MagnetometerEntity {
  MagnetometerModel({required super.degree});
}
