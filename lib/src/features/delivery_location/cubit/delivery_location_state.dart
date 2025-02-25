part of 'delivery_location_cubit.dart';

sealed class DeliveryLocationState extends Equatable {
  const DeliveryLocationState();

  @override
  List<Object> get props => <Object>[];
}

class Loading extends DeliveryLocationState{}

class Error extends DeliveryLocationState{}

class Success extends DeliveryLocationState{}
