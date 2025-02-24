import 'dart:async';
import 'dart:io';

import 'package:geolocator/geolocator.dart';

class LocationDatasource {
  Stream<Position> getCurrentLocation() {
    return Geolocator.getPositionStream(
      locationSettings: _isAndroid ? _androidSettings : _iosSettings,
    );
  }

  LocationSettings get _androidSettings => AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
        intervalDuration: Duration(milliseconds: 200),

        foregroundNotificationConfig: ForegroundNotificationConfig(
          notificationTitle: 'Obteniendo ubicación actual',
          notificationText:
              'La ubicación actual se está obteniendo en segundo plano',
          notificationChannelName: 'Ubicación actual',
          enableWakeLock: true,
        ),
      );

  LocationSettings get _iosSettings => AppleSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
        showBackgroundLocationIndicator: true,
        pauseLocationUpdatesAutomatically: false,
      );

  bool get _isAndroid => Platform.isAndroid;
}
