import 'package:quickdrop_delivery/src/features/orders/domain/entity/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required super.description,
    required super.position,
  });

  factory AddressModel.fromJson({required Map<String, dynamic> json}) {
    return AddressModel(
      description: json['description'],
      position: json['position'],
    );
  }
}
