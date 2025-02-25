import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extensions/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrdersDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  Stream<List<Map<String, dynamic>>> getOrders() {
    try {
      final Stream<QuerySnapshot<Map<String, dynamic>>> data = _firestore
          .collectionGroup('orders')
          .where(
            'delivery_agent',
            isEqualTo: _uid,
          )
          .snapshots();

      return data.toMapJsonListStream();
    } catch (e) {
      rethrow;
    }
  }
}
