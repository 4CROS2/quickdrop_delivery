import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quickdrop_delivery/src/features/location/domain/usecase/location_usecase.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required LocationUsecase usecase})
      : _usecase = usecase,
        super(LocationInitial()) {
    getLocation();
  }
  final LocationUsecase _usecase;
  StreamSubscription<Position>? _subscription;

  void getLocation() async {
    try {
      await _getPermission();
      _subscription = _usecase.streamLocation.listen((Position position) {
        _onSuccess(position: position);
      }, onError: _onError);
    } catch (e) {
      _onError(e);
    }
  }

  Future<void> _getPermission() async {
    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'permiso denegado por el usuario';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'permiso denegado permanentemente por el usuario';
      }
    } catch (e) {
      rethrow;
    }
  }

  void _onSuccess({required Position position}) {
    emit(Success(position: position));
  }

  void _onError(Object error) {
    emit(
      Error(
        message: error.toString(),
      ),
    );
  }

  void pauseLocationStream() {
    _subscription?.pause();
  }

  void resumeLocationStream() {
    _subscription?.resume();
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
