import 'package:cloud_firestore/cloud_firestore.dart';

class AddressEntity {
  AddressEntity({
    required this.description,
    required this.position,
  });
  final String description;
  final GeoPoint position;
}
