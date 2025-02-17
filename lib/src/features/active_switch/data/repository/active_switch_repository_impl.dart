import 'package:quickdrop_delivery/src/features/active_switch/data/datasource/active_switch_datasource.dart';
import 'package:quickdrop_delivery/src/features/active_switch/domain/repository/active_switch_repository.dart';

/// Implementation of the ActiveSwitchRepository for managing the active switch status of a delivery agent.
class IActiveSwitchRepository implements ActiveSwitchRepository {
  /// Creates an instance of IActiveSwitchRepository with the given datasource.
  ///
  /// The [datasource] is required to interact with the underlying data store.
  IActiveSwitchRepository({
    required ActiveSwitchDatasource datasource,
  }) : _datasource = datasource;

  final ActiveSwitchDatasource _datasource;

  /// Streams the current status of the delivery agent.
  ///
  /// Returns a [Stream] of [bool] indicating the current status.
  @override
  Stream<bool> getStatus() {
    final Stream<Map<String, dynamic>> response = _datasource.getStatus();

    final Stream<bool> status = response.map((Map<String, dynamic> event) {
      return event['agent_availability'] as bool;
    });
    return status;
  }

  /// Updates the active switch status of the delivery agent.
  ///
  /// This method toggles the current status of the agent's availability
  /// and updates the status in the underlying data store.
  @override
  Future<void> updateStatus() async => await _datasource.updateStatus();
}
