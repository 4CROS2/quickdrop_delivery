import 'package:location/location.dart';

abstract class LocationRepository {
  Stream<LocationData> get streamLocation;
  Future<bool> requestPermission();
}
