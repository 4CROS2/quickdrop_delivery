part of 'active_switch_cubit.dart';

enum ActiveState { loading, success, error, initial }

class ActiveSwitchState extends Equatable {
  const ActiveSwitchState({
    this.isActive = false,
    this.activeState = ActiveState.initial,
    this.message = '',
  });

  final bool isActive;
  final ActiveState activeState;
  final String message;

  ActiveSwitchState copyWith({
    bool? isActive,
    ActiveState? activeState,
    String? message,
  }) {
    return ActiveSwitchState(
      isActive: isActive ?? this.isActive,
      activeState: activeState ?? this.activeState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => <Object>[isActive, activeState, message];
}
