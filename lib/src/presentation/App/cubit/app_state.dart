part of 'app_cubit.dart';

enum AppStatus { authenticated, unauthenticated, loading }

class AppState extends Equatable {
  const AppState({
    this.appStatus = AppStatus.loading,
    this.user = const DeliveryAgentEntity(
      email: '',
      id: '',
      lastname: '',
      name: '',
      phone: '',
    ),
  });
  final DeliveryAgentEntity user;
  final AppStatus appStatus;

  AppState copyWith({
    DeliveryAgentEntity? user,
    AppStatus? appStatus,
  }) {
    return AppState(
      appStatus: appStatus ?? this.appStatus,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => <Object?>[appStatus, user];
}
