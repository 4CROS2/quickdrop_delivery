import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_delivery/src/domain/entity/order_entity.dart';
import 'package:quickdrop_delivery/src/domain/usecase/orders_usecase.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit({
    required OrdersUsecase usecase,
  })  : _usecase = usecase,
        super(Loading()) {
    getOrders();
  }

  final OrdersUsecase _usecase;

  late StreamSubscription<List<OrderEntity>> _subscription;

  void getOrders() {
    emit(Loading());
    _subscription = _usecase.getOrders.listen(
      (List<OrderEntity> orders) => _success(
        orders: orders,
      ),
      onError: _onError,
    );
  }

  void _success({required List<OrderEntity> orders}) async {
    emit(
      Success(
        orders: orders,
      ),
    );
  }

  void _onError(Object error) {
    emit(
      Error(
        message: error.toString(),
      ),
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
