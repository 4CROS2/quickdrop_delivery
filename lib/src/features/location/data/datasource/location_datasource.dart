import 'dart:io' show Platform;
import 'package:geolocator/geolocator.dart';

class LocationDatasource {
  Stream<Position> get streamLocation {
    if (Platform.isAndroid) {
      // Configuración para Android
      return Geolocator.getPositionStream(
        locationSettings: AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 1, // Actualización por cada metro
          intervalDuration: const Duration(seconds: 1), // Cada 1 segundo
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
}
