import 'package:quickdrop_delivery/src/features/auth/login/domain/entity/delivery_agent_entity.dart';
import 'package:quickdrop_delivery/src/features/auth/login/domain/repository/auth_repository.dart';

class AuthUseCase {
  AuthUseCase({
    required AuthRepository repository,
  }) : _repository = repository;
  final AuthRepository _repository;

  Stream<DeliveryAgentEntity> deliveryStatus() {
    final Stream<DeliveryAgentEntity> data = _repository.deliveryStatus();
    return data;
  }

  Future<DeliveryAgentEntity> login({
    required String email,
    required String password,
  }) async {
    return await _repository.login(
      email: email,
      password: password,
    );
  }

  Future<DeliveryAgentEntity> signUp({
    required String email,
    required String password,
    required String name,
    required String lastName,
    required String phone,
  }) async {
    return await _repository.signUp(
      name: name,
      lastName: lastName,
      phone: phone,
      email: email,
      password: password,
    );
  }

  Future<DeliveryAgentEntity> googleSignin() async =>
      await _repository.googleSignin();

  Future<void> logOut() async {
    return await _repository.logout();
  }
}
