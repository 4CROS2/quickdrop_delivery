part of 'app_cubit.dart';

enum AppStatus { authenticated, unauthenticated, loading }

enum AppThemeState { dark, light, device }

class AppState extends Equatable {
  const AppState({
    this.appStatus = AppStatus.loading,
    this.appTheme = AppThemeState.light,
    this.deliveyAgent = const DeliveryAgentEntity.empty(),
  });
  final DeliveryAgentEntity deliveyAgent;
  final AppStatus appStatus;
  final AppThemeState appTheme;

  AppState copyWith({
    DeliveryAgentEntity? deliveryAgent,
    AppStatus? appStatus,
    AppThemeState? appTheme,
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
