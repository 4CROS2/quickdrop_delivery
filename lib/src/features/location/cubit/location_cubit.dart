import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickdrop_delivery/src/features/location/domain/usecase/location_usecase.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required LocationUsecase usecase})
      : _usecase = usecase,
        super(LocationInitial());

  final LocationUsecase _usecase;

  /// Inicia la obtención de la ubicación en tiempo real.
  Future<void> getLocation() async {
    try {
      bool hasPermission = await _checkAndRequestPermission();
      if (!hasPermission) {
        return;
      }

      await _startLocationStream();
    } catch (e) {
      _onError(e);
    }
  }

  /// Verifica y solicita permisos de ubicación.
  Future<bool> _checkAndRequestPermission() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw Exception('El servicio de ubicación está deshabilitado.');
      }

      PermissionStatus permission = await Permission.locationAlways.request();
      if (permission.isDenied || permission.isPermanentlyDenied) {
        throw Exception('Permiso de ubicación denegado.');
      }

      if (permission == PermissionStatus.permanentlyDenied) {
        _onError('El permiso de ubicación ha sido denegado permanentemente.');
        return false;
      }

      return true;
    } catch (e) {
      _onError('Error verificando permisos: $e');
      return false;
    }
  }

  /// Inicia el stream de ubicación en tiempo real.
  Future<void> _startLocationStream() async {
    await _usecase.startStreamLocation();
    _usecase.streamLocation.listen(
      _onSuccess,
      onError: _onError,
    );
  }

  /// Emite estado de éxito con la nueva posición.
  void _onSuccess(Position position) {
    emit(Success(position: position));
  }

  /// Manejo de errores con emisión de estado.
  void _onError(Object error) {
    emit(Error(message: error.toString()));
  }

  void stopLocationStream() {
    _usecase.stopStreamLocation();
    emit(LocationInitial());
  }

  @override
  Future<void> close() async {
    await _usecase.stopStreamLocation();
    return super.close();
  }
}
