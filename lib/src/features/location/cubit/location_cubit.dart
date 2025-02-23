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
  StreamSubscription<Position>? _locationSubscription;

  Future<void> getLocation() async {
    try {
      emit(Loading());
      bool hasPermission = await _checkAndRequestPermission();
      if (!hasPermission) {
        emit(const Error(message: 'No se concedieron los permisos necesarios'));
        return;
      }
      await _startLocationStream();
    } catch (e) {
      emit(Error(message: 'Error al iniciar la ubicación: $e'));
    }
  }

  Future<bool> _checkAndRequestPermission() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw Exception('El servicio de ubicación está deshabilitado.');
      }

      PermissionStatus permission = await Permission.locationAlways.request();
      if (permission.isDenied || permission.isPermanentlyDenied) {
        throw Exception('Permiso de ubicación denegado.');
      }
      return true;
    } catch (e) {
      emit(Error(message: 'Error verificando permisos: $e'));
      return false;
    }
  }

  Future<void> _startLocationStream() async {
    await _locationSubscription?.cancel();
    _locationSubscription = null;

    await _usecase.startStreamLocation();
    _locationSubscription = _usecase.streamLocation.listen(
      (Position position) {
        emit(Success(position: position));
      },
      onError: (Object error) {
        emit(Error(message: error.toString()));
      },
    );
  }

  void stopLocationStream() async {
    await _locationSubscription?.cancel();
    _locationSubscription = null;
    await _usecase.stopStreamLocation();
    emit(LocationInitial());
  }

  @override
  Future<void> close() async {
    await _locationSubscription?.cancel();
    await _usecase.stopStreamLocation();
    _usecase.dispose();
    return super.close();
  }
}
