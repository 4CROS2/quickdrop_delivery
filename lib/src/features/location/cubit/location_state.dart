part of 'location_cubit.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => <Object>[];
}

class LocationInitial extends LocationState {}

class Loading extends LocationState {}

class Error extends LocationState {
  const Error({required this.message});
  final String message;

  @override
  List<Object> get props => <Object>[message];
}

class Success extends LocationState {
  const Success({
    required this.gps,
  });

  final LocationAndSensorEntity gps;

  @override
  List<Object> get props => <Object>[gps];

  @override
  bool? get stringify => true;
}
