import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickdrop_delivery/src/features/orders/domain/entity/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.image,
    required super.productName,
    required super.address,
    required super.createdAt,
    required super.customerName,
    required super.contactNumber,
    required super.orderStatus,
    required super.productPrice,
  });

  static OrderModel fromJson({required Map<String, dynamic> json}) {
    final DateTime date = (json['created_at'] as Timestamp).toDate();
    return OrderModel(
      image: json['image'] ?? '',
      productName: json['product_name'] ?? '',
      address: json['address'] ?? '',
      createdAt: date,
      customerName: '',
      contactNumber: '',
      orderStatus: '',
      productPrice: (json['total_paid'] as int).toDouble(),
    );
  }
}
