import 'package:geolocator/geolocator.dart';
import 'package:quickdrop_delivery/src/features/location/data/datasource/location_datasource.dart';
import 'package:quickdrop_delivery/src/features/location/domain/repository/location_repository.dart';

class ILocationRepository implements LocationRepository {
  ILocationRepository({
    required LocationDatasource datasource,
  }) : _datasource = datasource;
  final LocationDatasource _datasource;

  @override
  Stream<Position> get streamLocation => _datasource.startStream();

  @override
  Future<void> stopStreamLocation() => _datasource.stopStreamLocation();

  @override
  Future<void> startStreamLocation() => _datasource.startStreamLocation();
}
