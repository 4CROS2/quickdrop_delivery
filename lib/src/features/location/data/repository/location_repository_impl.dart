import 'package:location/location.dart';
import 'package:quickdrop_delivery/src/features/location/data/datasource/location_datasource.dart';
import 'package:quickdrop_delivery/src/features/location/domain/repository/location_repository.dart';

class ILocationRepository implements LocationRepository {
  ILocationRepository({required LocationDatasource datasource})
      : _datasource = datasource;

  final LocationDatasource _datasource;

  @override
  Stream<LocationData> get streamLocation => _datasource.getCurrentLocation();

  @override
  Future<bool> requestPermission() => _datasource.requestPermission();
}
