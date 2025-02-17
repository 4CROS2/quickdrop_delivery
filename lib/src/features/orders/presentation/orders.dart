import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_delivery/src/injection/injection_container.dart';
import 'package:quickdrop_delivery/src/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:quickdrop_delivery/src/features/orders/presentation/widgets/orders_body.dart';
import 'package:quickdrop_delivery/src/features/loading/loading.dart';
import 'package:quickdrop_delivery/src/features/widgets/fade_transition_states/fade_transiton_states.dart';

class Orders extends StatefulWidget {
  const Orders({
    super.key,
  });

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersCubit>(
      create: (BuildContext context) => sl<OrdersCubit>(),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (BuildContext context, OrdersState state) {
          return FadetransitonStates(
            child: switch (state) {
              Loading _ => Center(
                  child: LoadingPage(),
                ),
              Error _ => Center(
                  child: Text(
                    state.message,
                  ),
                ),
              Success _ => OrdersBody(
                  orders: state.orders,
                )
            },
          );
        },
      ),
    );
  }
}
