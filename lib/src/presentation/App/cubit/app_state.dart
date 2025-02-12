part of 'app_cubit.dart';

enum AppStatus { authenticated, unauthenticated, loading }

enum AppTheme { dark, light, device }

class AppState extends Equatable {
  const AppState({
    this.appStatus = AppStatus.loading,
    this.appTheme = AppTheme.light,
    this.deliveyAgent = DeliveryAgentEntity.empty,
  });
  final DeliveryAgentEntity deliveyAgent;
  final AppStatus appStatus;
  final AppTheme appTheme;

  AppState copyWith({
    DeliveryAgentEntity? deliveryAgent,
    AppStatus? appStatus,
    AppTheme? appTheme,
  }) {
    return AppState(
      appStatus: appStatus ?? this.appStatus,
      deliveyAgent: deliveryAgent ?? deliveyAgent,
      appTheme: appTheme ?? this.appTheme,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        appStatus,
        deliveyAgent,
        appTheme,
      ];
}
