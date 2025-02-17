import 'package:quickdrop_delivery/src/domain/entity/order_entity.dart';
import 'package:quickdrop_delivery/src/domain/repository/orders_repository.dart';

class OrdersUsecase {
  OrdersUsecase({
    required OrdersRepository repository,
  }) : _repository = repository;
  final OrdersRepository _repository;

  Stream<List<OrderEntity>> get getOrders => _repository.getOrders();
}
