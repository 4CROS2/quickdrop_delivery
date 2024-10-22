part of 'app_cubit.dart';

enum AppStatus { authenticated, unauthenticated, loading }

class AppState extends Equatable {
  const AppState({
    this.appStatus = AppStatus.loading,
    this.deliveyAgent = DeliveryAgentEntity.empty,
  });
  final DeliveryAgentEntity deliveyAgent;
  final AppStatus appStatus;

  AppState copyWith({
    DeliveryAgentEntity? deliveryAgent,
    AppStatus? appStatus,
  }) {
    return AppState(
      appStatus: appStatus ?? this.appStatus,
      deliveyAgent: deliveryAgent ?? deliveyAgent,
    );
  }

  @override
  List<Object?> get props => <Object?>[appStatus, deliveyAgent];
}
