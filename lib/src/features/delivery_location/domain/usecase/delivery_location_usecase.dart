import 'package:location/location.dart';
import 'package:quickdrop_delivery/src/features/delivery_location/domain/repository/delivery_location_repository.dart';

class DeliveryLocationUsecase {
  DeliveryLocationUsecase({
    required DeliveryLocationRepository repository,
  }) : _repository = repository;

  final DeliveryLocationRepository _repository;

  Future<void> updateLocation({required LocationData location}) async {
    await _repository.updateCurrentLocation(location: location);
  }
}
