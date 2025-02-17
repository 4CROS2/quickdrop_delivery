import 'package:quickdrop_delivery/src/features/auth/login/domain/entity/delivery_agent_entity.dart';
import 'package:quickdrop_delivery/src/features/auth/login/domain/repository/auth_repository.dart';

class AppUsecase {
  AppUsecase({
    required AuthRepository repository,
  }) : _repository = repository;

  final AuthRepository _repository;

  Stream<DeliveryAgentEntity> get deliveryStatus =>
      _repository.deliveryStatus();
}
