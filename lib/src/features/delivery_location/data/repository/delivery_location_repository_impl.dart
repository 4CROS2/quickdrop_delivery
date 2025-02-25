import 'package:location/location.dart';
import 'package:quickdrop_delivery/src/features/delivery_location/data/datasource/delivery_location_datasource.dart';
import 'package:quickdrop_delivery/src/features/delivery_location/domain/repository/delivery_location_repository.dart';

class IDeliveryLocationRepository extends DeliveryLocationRepository {
  IDeliveryLocationRepository({
    required DeliveryLocationDatasource datasource,
  }) : _datasource = datasource;
  final DeliveryLocationDatasource _datasource;

  @override
  Future<void> updateCurrentLocation({required LocationData location}) async {
    await _datasource.updateLocation(location: location);
  }
}
