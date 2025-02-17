import 'package:quickdrop_delivery/src/domain/repository/active_switch_repository.dart';

/// A use case class for managing the active switch status of a delivery agent.
class SwitchStatusUsecase {
  /// Creates an instance of SwitchStatusUsecase with the given repository.
  ///
  /// The [repository] is required to interact with the underlying data store.
  SwitchStatusUsecase({
    required ActiveSwitchRepository repository,
  }) : _repository = repository;

  final ActiveSwitchRepository _repository;

  /// Streams the current status of the delivery agent.
  ///
  /// Returns a [Stream] of [bool] indicating the current status.
  Stream<bool> getStatus() => _repository.getStatus();

  /// Updates the active switch status of the delivery agent.
  ///
  /// This method toggles the current status of the agent's availability
  /// and updates the status in the underlying data store.
  Future<void> updateStatus() async => await _repository.updateStatus();
}
