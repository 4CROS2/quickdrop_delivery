import 'package:quickdrop_delivery/src/features/orders/domain/entity/order_entity.dart';

abstract class OrdersRepository {
  Stream<List<OrderEntity>> getOrders();
}
