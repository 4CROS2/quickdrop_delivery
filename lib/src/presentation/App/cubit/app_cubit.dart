import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_delivery/src/domain/entity/delivery_agent_entity.dart';
import 'package:quickdrop_delivery/src/domain/usecase/auth_usecase.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required AuthUseCase usecase,
  })  : _useCase = usecase,
        super(
          AppState(),
        ) {
    _authSubscription();
  }

  final AuthUseCase _useCase;
  StreamSubscription<DeliveryAgentEntity>? _subscription;

  void _authSubscription() {
    _emitLoadingState();
    _subscription = _useCase.deliveryStatus().listen(
          (DeliveryAgentEntity deliveryAgent) => _onDeliveryAgentUpdated(
            deliveryAgent: deliveryAgent,
          ),
          onError: _onError,
        );
  }

  void _emitLoadingState() {
    emit(state.copyWith(appStatus: AppStatus.loading));
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
        deliveryAgent: DeliveryAgentEntity.empty,
        appStatus: AppStatus.unauthenticated,
      ),
    );
  }

  void _onDeliveryAgentUpdated({required DeliveryAgentEntity deliveryAgent}) {
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
