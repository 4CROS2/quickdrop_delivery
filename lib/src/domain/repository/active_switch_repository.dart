/// An abstract repository for managing the active switch status of a delivery agent.
abstract class ActiveSwitchRepository {
  /// Streams the current status of the delivery agent.
  ///
  /// Returns a [Stream] of [bool] indicating the current status.
  /// Implementations should handle listening for real-time updates to the agent's status.
  Stream<bool> getStatus();

  /// Updates the active switch status of the delivery agent.
  ///
  /// This method should toggle the current status of the agent's availability
  /// and update the status in the underlying data store.
  Future<void> updateStatus();
}
