import 'package:flutter/material.dart';
import 'package:quickdrop_delivery/src/core/constants/constants.dart';
import 'package:quickdrop_delivery/src/domain/entity/order_entity.dart';
import 'package:quickdrop_delivery/src/presentation/home/widgets/orders/widgets/empty_orders.dart';
import 'package:quickdrop_delivery/src/presentation/home/widgets/orders/widgets/order_tile.dart';
import 'package:quickdrop_delivery/src/presentation/widgets/fade_transition_states/fade_transiton_states.dart';

class OrdersBody extends StatefulWidget {
  const OrdersBody({
    required List<OrderEntity> orders,
    super.key,
  }) : _orders = orders;
  final List<OrderEntity> _orders;

  @override
  State<OrdersBody> createState() => _OrdersBodyState();
}

class _OrdersBodyState extends State<OrdersBody> {
  @override
  Widget build(BuildContext context) {
    return FadetransitonStates(
      child: switch (widget._orders.isEmpty) {
        true => EmptyOrders(),
        false => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: Constants.mainPadding.left,
                  top: Constants.mainPadding.top,
                ),
                child: Text(
                  'Domicilios pendientes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Flexible(
                child: ListView.separated(
                  padding: Constants.mainPadding,
                  itemCount: widget._orders.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return OrderTile(
                      order: widget._orders[index],
                    );
                  },
                ),
              ),
            ],
          ),
      },
    );
  }
}
