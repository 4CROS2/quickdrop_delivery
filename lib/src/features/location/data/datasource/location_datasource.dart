import 'dart:async';

import 'package:location/location.dart';

class LocationDatasource {
  final Location _location = Location();

  Stream<LocationData> getCurrentLocation() {
    return _location.onLocationChanged;
  }

  Future<bool> requestPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Verifica si el servicio de ubicación está habilitado
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    // Solicita permisos si no están otorgados
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      await _location.enableBackgroundMode();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    // Configura la frecuencia y precisión de las actualizaciones
    await _location.changeSettings(
      accuracy: LocationAccuracy.high, // Alta precisión
      interval: 200, // Actualización cada 0.5 segundos
      distanceFilter: 1,
      // Actualiza si se mueve 1 metro
    );

    return true;
  }
}
