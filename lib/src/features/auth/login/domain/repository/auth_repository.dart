import 'package:quickdrop_delivery/src/features/auth/login/domain/entity/delivery_agent_entity.dart';

abstract class AuthRepository {
  Stream<DeliveryAgentEntity> deliveryStatus();

  Future<DeliveryAgentEntity> login({
    required String email,
    required String password,
  });
  Future<DeliveryAgentEntity> signUp({
    required String name,
    required String lastName,
    required String phone,
    required String email,
    required String password,
  });
  Future<DeliveryAgentEntity> googleSignin();
  Future<void> logout();
}
