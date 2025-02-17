import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_delivery/src/features/active_switch/domain/usecase/switch_status_usecase.dart';

part 'active_switch_state.dart';

/// A Cubit for managing the active switch status of a delivery agent.
class ActiveSwitchCubit extends Cubit<ActiveSwitchState> {
  /// Creates an instance of ActiveSwitchCubit with the given usecase.
  ///
  /// The [usecase] is required to interact with the underlying business logic.
  ActiveSwitchCubit({
    required SwitchStatusUsecase usecase,
  })  : _usecase = usecase,
        super(ActiveSwitchState()) {
    _getStatus();
  }

  final SwitchStatusUsecase _usecase;

  late final StreamSubscription<bool> _switchStreamSubscription;

  /// Retrieves the current status of the delivery agent.
  ///
  /// This method listens for real-time updates to the agent's status
  /// and updates the state accordingly.
  void _getStatus() {
    _switchStreamSubscription = _usecase.getStatus().listen(
      (bool event) {
        _onSuccess(isActive: event);
      },
      onError: _onError,
    );
  }

  /// Changes the active switch status of the delivery agent.
  ///
  /// This method toggles the current status of the agent's availability
  /// and updates the state with the new status.
  Future<void> changeStatus() async {
    _onLoading();
    try {
      await _usecase.updateStatus();
    } catch (e) {
      _onError(e);
    }
  }

  /// Updates the state to loading.
  void _onLoading() {
    emit(
      state.copyWith(
        isActive: state.isActive,
        activeState: ActiveState.loading,
        message: '',
      ),
    );
  }

  /// Updates the state to success with the given active status.
  ///
  /// The [isActive] parameter indicates the new active status of the delivery agent.
  void _onSuccess({required bool isActive}) {
    emit(
      state.copyWith(
          isActive: isActive, activeState: ActiveState.success, message: ''),
    );
  }

  /// Updates the state to error with the given error message.
  ///
  /// The [error] parameter provides information about the error that occurred.
  void _onError(Object error) {
    emit(
      state.copyWith(
        isActive: false,
        activeState: ActiveState.error,
        message: error.toString(),
      ),
    );
  }

  /// Cancels the stream subscription when the Cubit is closed.
  @override
  Future<void> close() {
    _switchStreamSubscription.cancel();
    return super.close();
  }
}
