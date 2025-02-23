import 'dart:async';
import 'dart:io' show Platform;

import 'package:geolocator/geolocator.dart';

class LocationDatasource {
  StreamSubscription<Position>? _subscription;
  final StreamController<Position> _locationStreamController =
      StreamController<Position>.broadcast();

  Stream<Position> get _streamLocation {
    if (Platform.isAndroid) {
      // Configuración para Android
      return Geolocator.getPositionStream(
        locationSettings: AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 1, // Actualización por cada metro
        ),
      );
    } else if (Platform.isIOS) {
      // Para iOS se utiliza AppleSettings (no permite configurar intervalos de tiempo)
      return Geolocator.getPositionStream(
        locationSettings: AppleSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 1, // Actualización por cada metro
        ),
      );
    } else {
      // Configuración por defecto para otras plataformas
      return Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 1,
        ),
      );
    }
  }

  StreamSubscription<Position>? get subscription => _subscription;

  Stream<Position> get locationStream => _locationStreamController.stream;

  Future<void> startLocationStream() async {
    await stopLocationStream();

    _subscription = _streamLocation.listen(
      (Position position) {
        _locationStreamController.add(position);
      },
      onError: (Object error) {
        _locationStreamController.addError(error);
      },
    );
  }

  Future<void> stopLocationStream() async {
    if (_subscription != null) {
      await _subscription!.cancel();
      _subscription = null;
    }
  }
}
