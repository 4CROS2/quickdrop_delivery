import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickdrop_delivery/src/domain/entity/delivery_agent_entity.dart';

class DeliveryAgentModel extends DeliveryAgentEntity {
  const DeliveryAgentModel({
    required super.id,
    required super.email,
    required super.phone,
    required super.name,
    required super.lastname,
  });
  static DeliveryAgentModel fromFireBase({required UserCredential credential}) {
    return DeliveryAgentModel(
      id: credential.user?.uid ?? '',
      email: credential.user?.email ?? '',
      phone: '',
      lastname: '',
      name: '',
    );
  }

  static DeliveryAgentModel fromJson({required Map<String, dynamic> json}) {
    return DeliveryAgentModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      lastname: json['lastName'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
    };
  }
}
