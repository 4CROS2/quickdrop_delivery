import 'package:geolocator/geolocator.dart';

abstract class LocationRepository {
  Future<void> startStreamLocation();
  Future<void> stopStreamLocation();
  Stream<Position> get streamLocation;
  void dispose();
}
