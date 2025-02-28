import 'package:quickdrop_delivery/src/features/location/domain/entity/location_and_sensor_entity.dart';

abstract class LocationRepository {
  Stream<LocationAndSensorEntity> get streamLocation;
  Future<bool> requestPermission();
}
