import 'package:location/location.dart';
import 'package:quickdrop_delivery/src/features/location/domain/repository/location_repository.dart';

class LocationUsecase {
  LocationUsecase({required LocationRepository repository})
      : _repository = repository;

  final LocationRepository _repository;

  Stream<LocationData> get streamLocation => _repository.streamLocation;
  Future<bool> requestPermission() => _repository.requestPermission();
}
