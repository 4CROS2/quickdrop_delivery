import 'dart:async';
import 'dart:io' show Platform;

import 'package:geolocator/geolocator.dart';

class LocationDatasource {
  StreamSubscription<Position>? _subscription;
  final StreamController<Position> _controller =
      StreamController<Position>.broadcast();

  Stream<Position> startStream() {
    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }
    _subscription = Geolocator.getPositionStream(
      locationSettings: _getLocationSettings(),
    ).listen((Position position) {
      _controller.add(position);
    }, onError: (Object error) {
      _controller.addError(error);
    });
    return _controller.stream;
  }

  Future<void> stopStreamLocation() async {
    await _subscription?.cancel();
    _subscription = null;
  }

  LocationSettings _getLocationSettings() {
    if (Platform.isAndroid) {
      return AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      );
    } else if (Platform.isIOS) {
      return AppleSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      );
    } else {
      return const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      );
    }
  }

  Future<void> startStreamLocation() async {
    startStream();
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _controller.close();
  }
}
