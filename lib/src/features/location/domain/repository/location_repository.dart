import 'package:geolocator/geolocator.dart';

abstract class LocationRepository {
  Stream<Position> get streamLocation;
}
