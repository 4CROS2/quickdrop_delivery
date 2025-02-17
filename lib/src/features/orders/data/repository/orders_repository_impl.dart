import 'package:quickdrop_delivery/src/features/orders/data/datasource/orders_datasource.dart';
import 'package:quickdrop_delivery/src/features/orders/data/model/orders_model.dart';
import 'package:quickdrop_delivery/src/features/orders/domain/repository/orders_repository.dart';

class IOrdersRepository implements OrdersRepository {
  IOrdersRepository({
    required OrdersDatasource datasource,
  }) : _datasource = datasource;

  final OrdersDatasource _datasource;

  @override
  Stream<List<OrderModel>> getOrders() {
    try {
      return _datasource.getOrders().map(
        (List<Map<String, dynamic>> orders) {
          return orders
              .map(
                (Map<String, dynamic> json) => OrderModel.fromJson(
                  json: json,
                ),
              )
              .toList();
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
