import 'package:quickdrop_delivery/src/features/location/domain/entity/location_and_sensor_entity.dart';
import 'package:quickdrop_delivery/src/features/location/domain/repository/location_repository.dart';

class LocationUsecase {
  LocationUsecase({required LocationRepository repository})
      : _repository = repository;

  final LocationRepository _repository;

  Stream<LocationAndSensorEntity> get streamLocation =>
      _repository.streamLocation;
  Future<bool> requestPermission() => _repository.requestPermission();
}
