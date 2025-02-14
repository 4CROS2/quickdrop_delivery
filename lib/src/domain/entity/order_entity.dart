import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  const OrderEntity({
    required this.image,
    required this.productName,
    required this.address,
    required this.createdAt,
    required this.customerName,
    required this.contactNumber,
    required this.orderStatus,
    required this.productPrice,
  });

  final String image;
  final String productName;
  final String address;
  final DateTime createdAt;
  final String customerName;
  final String contactNumber;
  final String orderStatus; // e.g., 'Pending', 'Delivered'
  final double productPrice;

  @override
  List<Object?> get props => <Object?>[
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
