import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_delivery/src/core/constants/constants.dart';
import 'package:quickdrop_delivery/src/domain/entity/order_entity.dart';
import 'package:quickdrop_delivery/src/presentation/home/widgets/orders/empty_orders.dart';

class Orders extends StatefulWidget {
  const Orders({
    required List<OrderEntity> orders,
    super.key,
  }) : _orders = orders;

  final List<OrderEntity> _orders;
  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Constants.animationTransition * 10,
      reverseDuration: Constants.animationTransition * 10,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          alwaysIncludeSemantics: false,
          child: child,
        );
      },
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
                    return Material(
                      borderRadius: Constants.mainBorderRadius,
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: Constants.mainPadding / 2,
                          child: Row(
                            children: <Widget>[
                              Material(
                                surfaceTintColor: Constants.primaryColor,
                                elevation: 2,
                                shadowColor: Colors.transparent,
                                borderRadius: Constants.mainBorderRadius / 2,
                                child: SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: ClipRRect(
                                    borderRadius:
                                        Constants.mainBorderRadius / 2,
                                    child: CachedNetworkImage(
                                      imageUrl: widget._orders[index].image,
                                      fit: BoxFit.cover,
                                      errorWidget: (
                                        BuildContext context,
                                        String url,
                                        Object error,
                                      ) {
                                        return Center(
                                          child: Icon(Icons.error_rounded),
                                        );
                                      },
                                      progressIndicatorBuilder: (
                                        BuildContext context,
                                        String url,
                                        DownloadProgress progress,
                                      ) {
                                        return CupertinoActivityIndicator();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                widget._orders[index].productName,
                              ),
                              Spacer(),
                              Text(widget._orders[index].createdAt.hour.toString()),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
      },
    );
  }
}
