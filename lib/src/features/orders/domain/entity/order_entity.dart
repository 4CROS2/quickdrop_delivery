import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  const OrderEntity({
    required this.id,
    required this.image,
    required this.productName,
    required this.address,
    required this.createdAt,
    required this.customerName,
    required this.contactNumber,
    required this.orderStatus,
    required this.productPrice,
  });

  final String id;
  final String image;
  final String productName;
  final GeoPoint address;
  final DateTime createdAt;
  final String customerName;
  final String contactNumber;
  final String orderStatus;
  final double productPrice;

  @override
  List<Object?> get props => <Object?>[
        id,
        image,
        productName,
        address,
        createdAt,
        customerName,
        contactNumber,
        orderStatus,
        productPrice,
      ];
}
