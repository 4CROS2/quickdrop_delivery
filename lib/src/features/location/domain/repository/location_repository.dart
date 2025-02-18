import 'package:geolocator/geolocator.dart';

abstract class LocationRepository {
  Stream<Position> streamLocation();
}
