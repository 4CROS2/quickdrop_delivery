import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:quickdrop_delivery/src/features/delivery_location/domain/usecase/delivery_location_usecase.dart';

part 'delivery_location_state.dart';

class DeliveryLocationCubit extends Cubit<DeliveryLocationState> {
  DeliveryLocationCubit({required DeliveryLocationUsecase usecase})
      : _usecase = usecase,
        super(Loading());

  final DeliveryLocationUsecase _usecase;

  Future<void> updateLocation({required LocationData location}) async {
    await _usecase.updateLocation(location: location);
  }
}
