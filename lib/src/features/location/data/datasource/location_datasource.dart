import 'dart:async';

import 'package:flutter_compass/flutter_compass.dart';
import 'package:location/location.dart';
import 'package:quickdrop_delivery/src/features/location/data/model/location_and_sensor_model.dart';
import 'package:rxdart/rxdart.dart';

class LocationDatasource {
  final Location _location = Location();

  Stream<LocationAndSensorModel> getCurrentLocation() {
    // Stream de ubicación
    final Stream<LocationData> locationStream = _location.onLocationChanged;

    final Stream<double> headingStream = FlutterCompass.events!
        .map((CompassEvent event) => event.heading ?? 0.0);

    // Combinar ambos streams usando StreamZip
    return Rx.combineLatest2(
      locationStream,
      headingStream,
      (
        LocationData location,
        double heading,
      ) {
        return LocationAndSensorModel(
          location: location,
          magnetometer: MagnetometerModel(degree: heading),
        );
      },
    );
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
