import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:quickdrop_delivery/src/features/location/domain/usecase/location_usecase.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({
    required LocationUsecase usecase,
  })  : _usecase = usecase,
        super(LocationInitial());

  final LocationUsecase _usecase;
  StreamSubscription<LocationData>? _locationSubscription;

  Future<void> getLocation() async {
    try {
      emit(Loading());
      bool hasPermission = await _usecase.requestPermission();
      if (!hasPermission) {
        throw Exception('No se concedieron los permisos necesarios');
      }
      await _startLocationStream();
    } catch (e) {
      _onError('Error al iniciar la ubicación: $e');
    }
  }

  Future<void> _startLocationStream() async {
    await stopLocationStream();
    _locationSubscription = _usecase.streamLocation.listen(
      _onSuccess,
      onError: _onError,
    );
  }

  void _onSuccess(LocationData locationData) {
    emit(
      Success(
        position: locationData,
      ),
    );
  }

  void _onError(Object error) {
    emit(
      Error(
        message: error.toString(),
      ),
    );
  }

  Future<void> stopLocationStream() async {
    await _locationSubscription?.cancel();
    _locationSubscription = null;
    emit(LocationInitial());
  }

  @override
  Future<void> close() async {
    await stopLocationStream();
    return super.close();
  }
}
