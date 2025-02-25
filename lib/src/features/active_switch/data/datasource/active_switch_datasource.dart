import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extensions/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A datasource for managing the active status of delivery agents.
class ActiveSwitchDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Gets the current user's UID.
  String get _uid => _auth.currentUser!.uid;

  /// The reference field name for agent availability status.
  String get _statusReference => 'status.availability';

  /// Gets the reference to the delivery agent's document in Firestore.
  DocumentReference<Map<String, dynamic>>
      get _deliveryAgentCollectionReference =>
          _firestore.collection('deliveryAgents').doc(_uid);

  /// Streams the current status of the delivery agent from Firestore.
  ///
  /// Returns a [Stream] of [Map<String, dynamic>] containing the status data.
  /// This method listens for real-time updates to the agent's document.
  Stream<Map<String, dynamic>> getStatus() {
    try {
      return _deliveryAgentCollectionReference.snapshots().toMapJsonStream();
    } catch (e) {
      rethrow;
    }
  }

  /// Updates the active status of the delivery agent in Firestore.
  ///
  /// This method toggles the current status of the agent's availability and
  /// updates the document in Firestore with the new status.
  Future<void> updateStatus() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> data =
          await _deliveryAgentCollectionReference.get();

      if (!data.exists || !data.data()!.containsKey('status')) {
        await _deliveryAgentCollectionReference.set(
          <String, Object>{
            'status': <String, Object>{
              'availability': true,
              'location': GeoPoint(0, 0),
              'updated_at': FieldValue.serverTimestamp(),
            }
          },
          SetOptions(
            merge: true,
          ),
        );
        return;
      }

      final Map<String, dynamic> currentStatusData = data.data()!;
      final Map<String, dynamic> currentStatusJson =
          currentStatusData['status'] as Map<String, dynamic>;
      final bool currentStatus = currentStatusJson['availability'] as bool;
      final bool newStatus = !currentStatus;
      await _deliveryAgentCollectionReference.update(<String, dynamic>{
        _statusReference: newStatus,
      });
    } catch (e) {
      rethrow;
    }
  }
}
