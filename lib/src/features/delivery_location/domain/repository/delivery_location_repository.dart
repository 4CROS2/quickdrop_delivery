import 'package:location/location.dart';

abstract class DeliveryLocationRepository {
  Future<void> updateCurrentLocation({required LocationData location});
}
