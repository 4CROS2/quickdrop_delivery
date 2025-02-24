import 'package:geolocator/geolocator.dart';
import 'package:quickdrop_delivery/src/features/location/domain/repository/location_repository.dart';

class LocationUsecase {
  LocationUsecase({
    required LocationRepository repository,
  }) : _repository = repository;
  final LocationRepository _repository;

  Stream<Position> get streamLocation => _repository.streamLocation;
}
