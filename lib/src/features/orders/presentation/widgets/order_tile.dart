import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickdrop_delivery/src/core/constants/constants.dart';
import 'package:quickdrop_delivery/src/features/orders/domain/entity/order_entity.dart';
import 'package:quickdrop_delivery/src/features/orders/presentation/widgets/cancel_order_alert.dart';
import 'package:quickdrop_delivery/src/features/orders/presentation/widgets/order_button.dart';
import 'package:quickdrop_delivery/src/features/orders/presentation/widgets/order_image.dart';
import 'package:quickdrop_delivery/src/features/orders/presentation/widgets/order_information.dart';

class OrderTile extends StatefulWidget {
  const OrderTile({
    required OrderEntity order,
    super.key,
  }) : _order = order;

  final OrderEntity _order;

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile>
    with SingleTickerProviderStateMixin {
  final GlobalKey _globalKey = GlobalKey();
  double _orderTileWidth = 0;
  double _orderTileHeight = 0;
  bool _isInitialized = false;

  late final AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 1),
    );
    _controller.addStatusListener(_getValue);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getOrderTileSize();
      setState(() {
        _animation = Tween<double>(
          begin: _orderTileWidth,
          end: 0,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ),
        );
        _isInitialized = true;
      });
      await _controller.forward();
    });
  }

  void _getOrderTileSize() {
    final RenderBox? renderBox =
        _globalKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      _orderTileWidth = renderBox.size.width;
      _orderTileHeight = renderBox.size.height;
    }
  }

  void _getValue(AnimationStatus status) {
    if (status == AnimationStatus.completed) {}
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Se devuelve siempre el widget completo para que el GlobalKey esté en el widget final.
    return Material(
      key: _globalKey,
      elevation: 6,
      borderRadius: Constants.mainBorderRadius,
      shadowColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      type: MaterialType.card,
      child: Stack(
        children: <Widget>[
          // Si ya se inicializó, se usa la animación; de lo contrario, se mantiene el ancho medido.
          AnimatedBuilder(
            animation: _isInitialized
                ? _animation
                : AlwaysStoppedAnimation<double>(_orderTileWidth),
            builder: (BuildContext context, Widget? child) {
              return Material(
                surfaceTintColor: Constants.secondaryColor,
                elevation: 2,
                shadowColor: Colors.transparent,
                child: SizedBox(
                  width: _isInitialized ? _animation.value : _orderTileWidth,
                  height: _orderTileHeight,
                ),
              );
            },
          ),
          Padding(
            padding: Constants.mainPadding / 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: Constants.mainPadding.top / 2,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: Constants.paddingValue / 2,
                  children: <Widget>[
                    OrderImage(
                      image: widget._order.image,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          OrderInformation(
                            data: widget._order.productName,
                          ),
                          OrderInformation(
                            data: widget._order.address.description,
                            size: 14,
                            iconData: Icons.location_on_rounded,
                          ),
                          OrderInformation(
                            data: widget._order.customerName,
                            size: 14,
                            iconData: Icons.storefront_outlined,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      DateFormat('HH:mm a').format(widget._order.createdAt),
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Row(
                    spacing: Constants.paddingValue / 2,
                    children: <Widget>[
                      OrderTuleButton(
                        onTap: () {},
                        text: 'aceptar',
                        color: Constants.primaryColor,
                        textColor: Colors.white,
                      ),
                      OrderTuleButton(
                        onTap: () {
                          showAdaptiveDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CancelOlderAlert();
                            },
                          );
                        },
                        text: 'rechazar',
                        surfaceColor: Constants.primaryColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
