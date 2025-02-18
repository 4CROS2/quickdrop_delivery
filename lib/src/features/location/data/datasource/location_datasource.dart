import 'package:geolocator/geolocator.dart';

class LocationDatasource {
  Stream<Position> get streamLocation => Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          distanceFilter: 1,
          accuracy: LocationAccuracy.high,
        ),
      );
}
