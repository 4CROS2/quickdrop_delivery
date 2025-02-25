import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

class DeliveryLocationDatasource {
  DeliveryLocationDatasource();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get _uid => _auth.currentUser!.uid;

  DocumentReference<Map<String, dynamic>> get _documentReference =>
      _firestore.collection('deliveryAgents').doc(_uid);

  Future<void> updateLocation({required LocationData location}) async {
    try {
      final GeoPoint geoPoint = GeoPoint(
        location.latitude!,
        location.longitude!,
      );
      await _documentReference.update(
        <String, dynamic>{
          'status.location': geoPoint,
          'status.updated_at': FieldValue.serverTimestamp(),
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
