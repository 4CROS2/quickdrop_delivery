import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_delivery/src/features/app/domain/usecase/app_usecase.dart';
import 'package:quickdrop_delivery/src/features/auth/login/domain/entity/delivery_agent_entity.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required AppUsecase usecase,
  })  : _useCase = usecase,
        super(
          AppState(),
        ) {
    _authSubscription();
  }

  final AppUsecase _useCase;
  StreamSubscription<DeliveryAgentEntity>? _subscription;

  void _authSubscription() {
    _emitLoadingState();
    _subscription = _useCase.deliveryStatus.listen(
      (DeliveryAgentEntity deliveryAgent) => _onDeliveryAgentUpdated(
        deliveryAgent: deliveryAgent,
      ),
      onError: _onError,
    );
  }

  void _emitLoadingState() {
    emit(
      state.copyWith(
        appStatus: AppStatus.loading,
      ),
    );
  }

  void _emitAuthenticatedState(DeliveryAgentEntity deliveryAgent) {
    emit(
      state.copyWith(
        deliveryAgent: deliveryAgent,
        appStatus: AppStatus.authenticated,
      ),
    );
  }

  void _emitUnauthenticatedState() {
    emit(
      state.copyWith(
        deliveryAgent: DeliveryAgentEntity.empty(),
        appStatus: AppStatus.unauthenticated,
      ),
    );
  }

  void _onDeliveryAgentUpdated({
    required DeliveryAgentEntity deliveryAgent,
  }) {
    if (deliveryAgent.id.isNotEmpty) {
      _emitAuthenticatedState(deliveryAgent);
    } else {
      _emitUnauthenticatedState();
    }
  }

  // ignore: always_specify_types
  void _onError(error) {
    _emitUnauthenticatedState();
  }

  void changeTheme({required AppThemeState themeMode}) {
    emit(state.copyWith(appTheme: themeMode));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
