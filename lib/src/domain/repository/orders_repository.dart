import 'package:quickdrop_delivery/src/domain/entity/order_entity.dart';

abstract class OrdersRepository {
  Stream<List<OrderEntity>> getOrders();
}
